import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {Player} from '@/domain/entities/player'
import type {Position} from '@/domain/entities/position'
import type {ServerMessage} from '@/domain/protocol/message'
import type {Transport} from '@/domain/protocol/transport'
import type {PlayerId} from '@/domain/types/ids'
import type {UnitType} from '@/domain/types/unit_type'

/** How long the bot waits between deployments */
const DEPLOY_INTERVAL_SECONDS = 2

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
  private battlefield: Battlefield | null = null
  private state: MatchState | null = null
  private ticksUntilDeploy = 0

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
        this.battlefield = message.battlefield
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
   * No strategy yet — it spends what it has on a random affordable unit in a
   * random lane at a steady interval, which is enough to keep a front on the
   * board. Targeting, lane choice and composition land once docs/specs.md
   * settles the rules.
   */
  private decide(): void {
    const config = this.config
    const battlefield = this.battlefield
    const state = this.state

    if (this.playerId === null || config === null || battlefield === null || state === null) {
      return
    }

    if (this.ticksUntilDeploy > 0) {
      this.ticksUntilDeploy -= 1

      return
    }

    const player = state.players.find((candidate) => candidate.id === this.playerId)

    if (player === undefined) {
      return
    }

    this.ticksUntilDeploy = Math.round(config.ticksPerSecond * DEPLOY_INTERVAL_SECONDS)

    const unitType = this.chooseUnit(config, player)
    const position = this.choosePosition(battlefield)

    if (unitType === undefined || position === undefined) {
      return
    }

    this.transport.send({
      kind: 'deploy_unit',
      unitType: unitType,
      position: position,
    })
  }

  /**
   * Picks a unit at random from the ones the bot can currently pay for.
   * Randomness here is unrelated to the engine's seeded generator: bot
   * decisions are commands, and a replay reads them back from the command log.
   * @param config - Tuning from the start message
   * @param player - The bot's own standing this tick
   * @returns A unit type, or undefined when nothing is affordable
   */
  private chooseUnit(config: MatchConfig, player: Player): UnitType | undefined {
    const affordable = Object.keys(config.units).filter((unitType) => {
      const stats = config.units[unitType]

      return stats !== undefined && stats.deploymentCost <= player.resources
    })

    return affordable[Math.floor(Math.random() * affordable.length)]
  }

  /**
   * Picks one of the bot's own launchers to deploy from, which is the same as
   * picking a lane.
   * @param battlefield - Layout from the start message
   * @returns Where to deploy, or undefined when the bot gates no lane
   */
  private choosePosition(battlefield: Battlefield): Position | undefined {
    const own = battlefield.launchers.filter((launcher) => launcher.ownerId === this.playerId)

    return own[Math.floor(Math.random() * own.length)]?.position
  }
}
