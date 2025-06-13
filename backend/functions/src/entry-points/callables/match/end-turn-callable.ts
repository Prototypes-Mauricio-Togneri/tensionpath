import {addMatchHistoryDocument} from '../../../collections/history/add-match-history-document'
import {getMatchDocument} from '../../../collections/match/get-match-document'
import {updateMatchDocument} from '../../../collections/match/update-match-document'
import {Database} from '../../../database/database'
import {Action} from '../../../models/action'
import {Location} from '../../../models/location'
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

    // TODO(momo): check if needs to pass turn

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
