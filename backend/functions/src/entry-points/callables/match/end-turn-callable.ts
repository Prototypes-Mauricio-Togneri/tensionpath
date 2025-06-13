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

    if (match.turn.turn != turnBefore) {
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

  // TODO(momo): search == and !=

  if (checkPlayersAlive({
    match: match,
    players: match.players,
  })) {
    const nodes = getNodesMap(match.battlefield.nodes)
    const actions = getActions(match.players)

    executeUnitDeployments({
      nodes: nodes,
      actions: actions.filter((a) => a.type === ActionType.deploy),
    })

    /* _executeUnitMovements(
      jsonMatch: jsonMatch,
      jsonNodes: jsonNodes,
      jsonPlayers: jsonMatch.players,
      jsonActions: jsonActions
          .where((a) => a.type == ActionType.move)
          .toList(),
      jsonConfig: jsonMatch.config,
    );*/

    /* _updatePlayerResources(
      jsonPlayers: jsonMatch.players,
      jsonNodes: jsonMatch.battlefield.nodes,
      jsonConfig: jsonMatch.config,
    );*/

    /* _updateMissile(
      jsonMissile: jsonMatch.battlefield.missile,
      jsonNodes: jsonMatch.battlefield.nodes,
    );*/
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

const getNodesMap = (nodes: Node[]): Nodes => {
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

const resetPlayers = (players: Players) => {
  for (const player of Object.values(players)) {
    player.status = PlayerStatus.playing
    player.turnEndedAt = undefined
    player.actions = []
  }
}

const isMissileFull = (missile: Missile) => {
  return (missile.charge === missile.maxCharge) && isMissileCharging(missile)
}

const isMissileCharging = (missile: Missile) => {
  return (missile.owner !== '') && (missile.owner !== undefined)
}

const updateTurn = (turn: Turn) => {
  turn.turn += 1
  turn.startedAt = new Date()
}

const locationId =(x: number, y: number): string => `${x},${y}`
