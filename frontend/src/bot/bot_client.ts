import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {ServerMessage} from '@/domain/protocol/message'
import type {Transport} from '@/domain/protocol/transport'
import type {PlayerId} from '@/domain/types/ids'

/**
 * The computer opponent.
 * A client like any other: it observes snapshots and issues commands through a
 * Transport, with no access to engine internals. That makes it fair by
 * construction — it sees exactly what a human client sees — and it depends only
 * on Transport, Command and ServerMessage, so it can later be hosted
 * server-side without a single change.
 */
export class BotClient {
  private readonly transport: Transport
  private playerId: PlayerId | null = null
  private config: MatchConfig | null = null
  private state: MatchState | null = null

  constructor(transport: Transport) {
    this.transport = transport
    this.transport.onMessage((message) => {
      this.handle(message)
    })
  }

  private handle(message: ServerMessage): void {
    switch (message.kind) {
      case 'welcome': {
        this.playerId = message.playerId
        break
      }
      case 'start': {
        this.config = message.config
        break
      }
      case 'update': {
        this.state = message.state
        this.decide()
        break
      }
    }
  }

  /**
   * Chooses commands for the current snapshot.
   * No strategy yet: deployment and targeting land once docs/specs.md settles
   * the unit roster.
   */
  private decide(): void {
    if (this.playerId === null || this.config === null || this.state === null) {
      return
    }

    // this.transport.send(...) once there is a roster to deploy from
  }
}
