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

/** How far past the legal margin the bot places a unit, in battlefield units */
const DEPLOY_INSET = 2

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
   * No strategy yet — it spends what it has on a random affordable unit at a
   * steady interval, which is enough to keep a front on the board. Targeting
   * and composition land once docs/specs.md settles the rules.
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

    const index = state.players.findIndex((candidate) => candidate.id === this.playerId)
    const player = state.players[index]

    if (player === undefined) {
      return
    }

    this.ticksUntilDeploy = Math.round(config.ticksPerSecond * DEPLOY_INTERVAL_SECONDS)

    const unitType = this.chooseUnit(config, player)

    if (unitType === undefined) {
      return
    }

    this.transport.send({
      kind: 'deploy_unit',
      unitType: unitType,
      position: this.choosePosition(config, battlefield, index),
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
   * Places the unit just inside the bot's own edge, at a random offset across
   * the field.
   * @param config - Tuning from the start message
   * @param battlefield - Layout from the start message
   * @param index - The bot's seat in the match, which decides its edge
   * @returns Where to deploy
   */
  private choosePosition(config: MatchConfig, battlefield: Battlefield, index: number): Position {
    const inset = config.deployMargin + DEPLOY_INSET
    const span = battlefield.size.height - (inset * 2)

    return {
      x: index === 0 ? inset : battlefield.size.width - inset,
      y: inset + (Math.random() * span),
    }
  }
}
