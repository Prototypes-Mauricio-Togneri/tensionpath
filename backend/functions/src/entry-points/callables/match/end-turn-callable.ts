import {addMatchHistoryDocument} from '../../../collections/history/add-match-history-document'
import {getMatchDocument} from '../../../collections/match/get-match-document'
import {updateMatchDocument} from '../../../collections/match/update-match-document'
import {Database} from '../../../database/database'
import {Action} from '../../../models/action'
import {Config} from '../../../models/config'
import {Location} from '../../../models/location'
import {Match} from '../../../models/match'
import {Missile} from '../../../models/missile'
import {Node, Nodes} from '../../../models/node'
import {Players} from '../../../models/player'
import {Turn} from '../../../models/turn'
import {Unit} from '../../../models/unit'
import {ActionType} from '../../../types/action-type'
import {MatchStatus} from '../../../types/match-status'
import {PlayerStatus} from '../../../types/player-status'
import {StructureType} from '../../../types/structure-type'
import {Constants} from '../../../utils/constants'
import {CustomInternalError} from '../../../utils/custom-internal-error'
import {registerCallable} from '../../index'

interface EndTurnCallableParams {
  userId: string,
  matchId: string,
  actions: Action[],
}

export const endTurnCallable = registerCallable(async (params: EndTurnCallableParams): Promise<void> => {
  return Database.runTransaction(async (database) => {
    const match = await getMatchDocument({
      database: database,
      matchId: params.matchId,
    })

    if (match.status === MatchStatus.finished) {
      throw new CustomInternalError({
        message: 'Match is already finished',
        data: {
          userId: params.userId,
          matchId: params.matchId,
        },
      })
    }

    const player = match.playerByUserId(params.userId)

    if (!player) {
      throw new CustomInternalError({
        message: 'Player does not exist in the match',
        data: {
          userId: params.userId,
          matchId: params.matchId,
        },
      })
    }

    if (player.status !== PlayerStatus.waiting) {
      throw new CustomInternalError({
        message: 'Player already ended turn',
        data: {
          userId: params.userId,
          matchId: params.matchId,
        },
      })
    }

    player.resources -= actionsCost(params.actions)
    player.status = PlayerStatus.waiting
    player.turnEndedAt = new Date()
    player.actions = params.actions

    const turnBefore = match.turn.turn

    const allPlayersWaiting = Object.values(match.players).every((p) => p.status === PlayerStatus.waiting)

    if (allPlayersWaiting) {
      updateMatch(match)
    }

    await updateMatchDocument({
      database: database,
      match: match,
    })

    if (match.turn.turn !== turnBefore) {
      await addMatchHistoryDocument({
        database: database,
        match: match,
      })
    }
  })
})

const actionsCost = (actions: Action[]): number => {
  let result = 0

  for (const action of actions) {
    if (action.type === ActionType.deploy) {
      result += action.level!
    } else if (action.type === ActionType.move) {
      const originLocation = new Location(action.originX!, action.originY!)
      const targetLocation = new Location(action.targetX, action.targetY)
      result += originLocation.distance(targetLocation)
    }
  }

  return result
}

// Update steps:
// * Check if the missile is full and launch it + update base health
// * If both players are alive, continue. If not, skip.
// * Execute unit deployments
// * Execute unit movements
//    * Update player base health in case of attack
// * Update players resources
// * Update missile
//    * Update charge
//    * Update platform owners
//    * Update missile owner
// * Reset players
//    * Set status to playing
//    * Clear turnEndedAt
//    * Clear actions
// * Update turn
//    * Increase turn counter
//    * Set turn started at
const updateMatch = (match: Match) => {
  checkMissile({
    missile: match.battlefield.missile,
    players: match.players,
    config: match.config,
  })

  // TODO(momo): remove properties temporaryUnits and hasMoved before writing to the database

  if (checkPlayersAlive({
    match: match,
    players: match.players,
  })) {
    const nodes = getNodes(match.battlefield.nodes)
    const actions = getActions(match.players)

    executeUnitDeployments({
      nodes: nodes,
      actions: actions.filter((a) => a.type === ActionType.deploy),
    })

    executeUnitMovements({
      match: match,
      nodes: nodes,
      players: match.players,
      actions: actions.filter((a) => a.type === ActionType.move),
      config: match.config,
    })

    updatePlayerResources({
      players: match.players,
      nodes: match.battlefield.nodes,
      config: match.config,
    })

    updateMissile({
      missile: match.battlefield.missile,
      nodes: match.battlefield.nodes,
    })
  }

  resetPlayers(match.players)

  updateTurn(match.turn)
}

const checkMissile = (params: {
  missile: Missile,
  players: Players,
  config: Config,
}) => {
  if (isMissileFull(params.missile)) {
    for (const [playerId, player] of Object.entries(params.players)) {
      if (params.missile.owner !== playerId) {
        player.baseHealth -= Math.floor(params.config.baseMaxHealth / 2)

        if (player.baseHealth < 0) {
          player.baseHealth = 0
        }
      }
    }
  }
}

const checkPlayersAlive = (params: {
  match: Match,
  players: Players,
}) => {
  let result = true

  for (const player of Object.values(params.players)) {
    if (player.baseHealth <= 0) {
      result = false
    }
  }

  if (!result) {
    params.match.status = MatchStatus.finished
  }

  return result
}

const getNodes = (nodes: Node[]): Nodes => {
  const result: Nodes = {}

  for (const node of Object.values(nodes)) {
    result[locationId(node.x, node.y)] = node
  }

  return result
}

const getActions = (players: Players): Action[] => {
  const result: Action[] = []

  for (const player of Object.values(players)) {
    result.push(...player.actions)
  }

  return result
}

const executeUnitDeployments = (params: {
  nodes: Nodes,
  actions: Action[],
}) => {
  for (const action of params.actions) {
    const nodeId = locationId(
        action.targetX,
        action.targetY,
    )
    const node = params.nodes[nodeId]!
    node.unit = new Unit({
      playerId: action.playerId,
      level: action.level!,
      hasMoved: false,
    })
  }
}

const executeUnitMovements = (params: {
  match: Match,
  nodes: Nodes,
  players: Players,
  actions: Action[],
  config: Config,
}) => {
  resetTemporaryUnits(params.nodes)
  fillTemporaryUnits({
    nodes: params.nodes,
    actions: params.actions,
  })
  resolveBattles({
    nodes: params.nodes,
    players: params.players,
    config: params.config,
  })
  checkBaseAttacks({
    match: params.match,
    nodes: params.nodes,
    players: params.players,
  })
}

const resetTemporaryUnits = (nodes: Nodes) => {
  for (const node of Object.values(nodes)) {
    node.temporaryUnits = []
  }
}

const fillTemporaryUnits = (params: {
  nodes: Nodes,
  actions: Action[],
}) => {
  for (const action of params.actions) {
    const originLocationId = locationId(
      action.originX!,
      action.originY!,
    )
    const originNode = params.nodes[originLocationId]!

    const targetLocationId = locationId(
        action.targetX,
        action.targetY,
    )
    const targetNode = params.nodes[targetLocationId]!

    const unit = originNode.unit!
    unit.hasMoved = true

    targetNode.temporaryUnits.push(unit)
    originNode.unit = undefined
  }

  for (const node of Object.values(params.nodes)) {
    if (node.unit) {
      const unit = node.unit!
      unit.hasMoved = false
      node.temporaryUnits.push(unit)
      node.unit = undefined
    }
  }
}

const resolveBattles = (params: {
  nodes: Nodes,
  players: Players,
  config: Config,
}) => {
  for (const node of Object.values(params.nodes)) {
    if (node.temporaryUnits.length === 1) {
      // Only one unit in the node, no battle
      const unit = node.temporaryUnits[0]
      unit.hasMoved = false

      node.unit = unit
    } else if (node.temporaryUnits.length > 1) {
      // More than one unit in the node, resolve battle
      resolveBattle({
        node: node,
        config: params.config,
      })
    }

    node.temporaryUnits = []
  }
}

const resolveBattle = (params: {
  node: Node,
  config: Config,
}) => {
  let player1Units = 0
  let player2Units = 0
  let player1Moved = false
  let player2Moved = false

  for (const unit of params.node.temporaryUnits) {
    if (unit.playerId === Constants.PLAYER_1) {
      player1Units += unit.level
      player1Moved = player1Moved || unit.hasMoved
    } else if (unit.playerId === Constants.PLAYER_2) {
      player2Units += unit.level
      player2Moved = player2Moved || unit.hasMoved
    }
  }

  const player1EffectiveUnits = player1Moved ?
      player1Units :
      Math.ceil(player1Units * 1.1)
  const player2EffectiveUnits = player2Moved ?
      player2Units :
      Math.ceil(player2Units * 1.1)

  if (player1EffectiveUnits > player2EffectiveUnits) {
    const remainingUnits = player1EffectiveUnits - player2EffectiveUnits

    // Player 1 wins
    params.node.unit = new Unit({
      playerId: Constants.PLAYER_1,
      level: Math.min(remainingUnits, player1Units),
      hasMoved: false,
    })
  } else if (player2EffectiveUnits > player1EffectiveUnits) {
    const remainingUnits = player2EffectiveUnits - player1EffectiveUnits

    // Player 2 wins
    params.node.unit = new Unit({
      playerId: Constants.PLAYER_2,
      level: Math.min(remainingUnits, player2Units),
      hasMoved: false,
    })
  } else {
    // Both players lose all units
    params.node.unit = undefined
  }
}

const checkBaseAttacks = (params: {
  match: Match,
  nodes: Nodes,
  players: Players,
}) => {
  for (const node of Object.values(params.nodes)) {
    if (node.structure && node.unit && (node.structure!.type === StructureType.launcher) && (node.unit!.playerId !== node.structure!.playerId)) {
      const player = params.players[node.structure!.playerId!]
      player.baseHealth -= node.unit!.level

      if (player.baseHealth < 0) {
        player.baseHealth = 0
        params.match.status = MatchStatus.finished
      }

      node.unit = undefined
    }
  }
}

const updatePlayerResources = (params: {
  players: Players,
  nodes: Node[],
  config: Config,
}) => {
  const player1 = params.players[Constants.PLAYER_1]!
  const player2 = params.players[Constants.PLAYER_2]!

  player1.resources += params.config.resourcesPerTurn
  player2.resources += params.config.resourcesPerTurn

  const player1TurnEndedAt = player1.turnEndedAt!
  const player2TurnEndedAt = player2.turnEndedAt!

  if (player1TurnEndedAt > player2TurnEndedAt) {
    const diffSeconds = Math.abs((player1TurnEndedAt.getTime() - player2TurnEndedAt.getTime()) / 1000)
    player2.resources += Math.floor(diffSeconds * params.config.resourcesPerSecond)
  } else if (player2TurnEndedAt > player1TurnEndedAt) {
    const diffSeconds = Math.abs((player2TurnEndedAt.getTime() - player1TurnEndedAt.getTime()) / 1000)
    player1.resources += Math.floor(diffSeconds * params.config.resourcesPerSecond)
  }

  for (const node of params.nodes) {
    if (node.structure && (node.structure!.type === StructureType.resources) && node.unit) {
      const player = params.players[node.unit!.playerId]!
      const newResources = Math.min(node.unit!.level, params.config.resourcesPerPatch)
      player.resources += newResources
    }
  }
}

const resetPlayers = (players: Players) => {
  for (const player of Object.values(players)) {
    player.status = PlayerStatus.playing
    player.turnEndedAt = undefined
    player.actions = []
  }
}

const updateMissile = (params: {
  missile: Missile,
  nodes: Node[],
}) => {
  const platforms = params.missile.platforms
  let player1 = 0
  let player2 = 0
  let none = 0

  for (const platformId of Object.keys(platforms)) {
    const platformOwner = getPlatformOwner({
      platformId: platformId,
      nodes: params.nodes,
    })
    platforms[platformId] = platformOwner

    if (platformOwner === Constants.PLAYER_1) {
      player1++
    } else if (platformOwner === Constants.PLAYER_2) {
      player2++
    } else if (platformOwner === undefined) {
      none++
    }
  }

  if (none === params.missile.numberOfPlatforms) {
    params.missile.owner = undefined
  } else if (player1 > player2) {
    params.missile.owner = Constants.PLAYER_1
  } else if (player2 > player1) {
    params.missile.owner = Constants.PLAYER_2
  } else if (player1 === player2) {
    params.missile.owner = ''
  }

  if (isMissileFull(params.missile)) {
    params.missile.charge = 0
  } else {
    params.missile.charge = nextMissileCharge(params.missile)
  }
}

const getPlatformOwner = (params: {
  platformId: string,
  nodes: Node[],
}): string | undefined => {
  const platformNodes = getPlatformNodes({
    platformId: params.platformId,
    nodes: params.nodes,
  })

  let player1 = 0
  let player2 = 0

  for (const nodeNode of platformNodes) {
    if (nodeNode.unit?.playerId === Constants.PLAYER_1) {
      player1++
    } else if (nodeNode.unit?.playerId === Constants.PLAYER_2) {
      player2++
    }
  }

  if ((player1 > 0) && (player2 === 0)) {
    return Constants.PLAYER_1
  } else if ((player2 > 0) && (player1 === 0)) {
    return Constants.PLAYER_2
  } else if ((player1 > 0) && (player2 > 0)) {
    return ''
  } else {
    return undefined
  }
}

const getPlatformNodes = (params: {
  platformId: string,
  nodes: Node[],
}): Node[] => {
  return params.nodes.filter((node) => node.structure?.platformId === params.platformId)
}

const isMissileFull = (missile: Missile) => {
  return (missile.charge === missile.maxCharge) && isMissileCharging(missile)
}

const isMissileCharging = (missile: Missile) => {
  return (missile.owner !== '') && (missile.owner !== undefined)
}

const nextMissileCharge = (missile: Missile): number => {
  if (isMissileCharging(missile)) {
    return missile.charge + 1
  } else if ((missile.owner === '') &&
      (missile.charge > missile.bufferCharge)) {
    return missile.charge - 1
  } else {
    return missile.charge
  }
}

const updateTurn = (turn: Turn) => {
  turn.turn += 1
  turn.startedAt = new Date()
}

const locationId =(x: number, y: number): string => `${x},${y}`
