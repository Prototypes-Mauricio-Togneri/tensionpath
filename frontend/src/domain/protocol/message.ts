import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {Command} from '@/domain/protocol/command'
import type {PlayerId} from '@/domain/types/ids'
import type {RejectionReason} from '@/domain/types/rejection_reason'

/**
 * Everything the authoritative engine sends to a client.
 * The handshake is welcome (who am I) then start (immutable layout and
 * tuning); after that only update messages flow.
 */
export type ServerMessage =
  | WelcomeMessage
  | StartMessage
  | UpdateMessage

export type WelcomeMessage = {
  kind: 'welcome'
  playerId: PlayerId
}

export type StartMessage = {
  kind: 'start'
  config: MatchConfig
  battlefield: Battlefield
}

/**
 * One simulated tick. The state replaces the client's previous copy outright,
 * so the client can never drift; events describe things that happened during
 * the tick and are discarded once consumed.
 */
export type UpdateMessage = {
  kind: 'update'
  tick: number
  state: MatchState
  events: MatchEvent[]
}

/**
 * Transient, single-tick notifications that a snapshot cannot express.
 * The union grows as rules land — impacts, deaths, node captures.
 */
export type MatchEvent = RejectedEvent

/**
 * A command the engine refused. Delivered only to the client that sent it.
 */
export type RejectedEvent = {
  kind: 'rejected'
  playerId: PlayerId
  command: Command
  reason: RejectionReason
}
