import {addMatchHistoryDocument} from '../../../collections/history/add-match-history-document'
import {getMatchDocument} from '../../../collections/match/get-match-document'
import {updateMatchDocument} from '../../../collections/match/update-match-document'
import {Database} from '../../../database/database'
import {MatchStatus} from '../../../types/match-status'
import {PlayerStatus} from '../../../types/player-status'
import {CustomInternalError} from '../../../utils/custom-internal-error'
import {registerCallable} from '../../index'

interface SurrenderCallableParams {
  userId: string,
  matchId: string,
}

export const surrenderCallable = registerCallable(async (params: SurrenderCallableParams): Promise<void> => {
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

    player.status = PlayerStatus.waiting
    player.turnEndedAt = new Date()
    player.baseHealth = 0

    match.status = MatchStatus.finished
    match.turn.turn += 1
    match.turn.startedAt = new Date()

    await updateMatchDocument({
      database: database,
      match: match,
    })

    await addMatchHistoryDocument({
      database: database,
      match: match,
    })
  })
})
