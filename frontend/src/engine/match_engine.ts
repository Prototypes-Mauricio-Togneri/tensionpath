import type {Battlefield} from '@/domain/entities/battlefield'
import type {Launcher} from '@/domain/entities/launcher'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {Player} from '@/domain/entities/player'
import type {Position} from '@/domain/entities/position'
import type {Command, DeployUnitCommand} from '@/domain/protocol/command'
import type {MatchEvent} from '@/domain/protocol/message'
import type {Transport} from '@/domain/protocol/transport'
import type {PlayerId} from '@/domain/types/ids'
import type {RejectionReason} from '@/domain/types/rejection_reason'
import {BASE_INCOME_MAX, BASE_INCOME_START, BASE_INCOME_STEP, BASE_INCOME_STEP_SECONDS} from '@/engine/balancing'
import {MILLIS_PER_SECOND, TICK_INTERVAL_MILLIS, TICK_INTERVAL_SECONDS} from '@/engine/constants'
import {LocalTransport} from '@/engine/local_transport'

/**
 * Whether a point falls inside a launcher's square.
 * @param launcher - The gate being tested
 * @param position - The point to test
 * @returns True when the point is inside the gate
 */
function covers(launcher: Launcher, position: Position): boolean {
  const insideX = Math.abs(position.x - launcher.position.x) <= launcher.size.width / 2
  const insideY = Math.abs(position.y - launcher.position.y) <= launcher.size.height / 2

  return insideX && insideY
}

/**
 * Identity a player is created with when a match is set up.
 */
export type PlayerSetup = {
  id: PlayerId
  name: string
}

/**
 * Everything needed to construct a match.
 */
export type MatchEngineOptions = {
  config: MatchConfig
  battlefield: Battlefield
  players: PlayerSetup[]
  randomSeed: number
}

type QueuedCommand = {
  playerId: PlayerId
  command: Command
}

/**
 * The authoritative simulation — the component that plays the role a match
 * server would.
 * Sole owner of match state: clients submit commands and receive snapshots,
 * and never hold a reference into the state kept here. It depends on nothing
 * from the browser or Vue, so it can be hosted in Node behind a socket without
 * modification.
 */
export class MatchEngine {
  private readonly config: MatchConfig
  private readonly battlefield: Battlefield
  private readonly connections = new Map<PlayerId, LocalTransport>()
  private readonly queue: QueuedCommand[] = []
  private readonly state: MatchState
  private ticks = 0
  private nextUnitNumber = 1 // Source of unit ids; deterministic, so replays match
  private accumulatedSeconds = 0
  private previousMillis = 0
  private timer: ReturnType<typeof setInterval> | null = null

  constructor(options: MatchEngineOptions) {
    this.config = options.config
    this.battlefield = options.battlefield
    this.state = {
      status: 'pending',
      elapsedSeconds: 0,
      players: options.players.map((player) => ({
        id: player.id,
        name: player.name,
        baseHealth: options.config.baseHealth,
        resources: options.config.startingResources,
      })),
      units: [],
      nodes: options.battlefield.nodes.map((node) => ({
        id: node.id,
        ownerId: null,
        depleted: false,
      })),
      randomSeed: options.randomSeed,
    }
  }

  get isRunning(): boolean {
    return this.timer !== null
  }

  /**
   * Attaches a client and completes the welcome and start handshake.
   * @param playerId - The player this connection acts for
   * @returns The transport the client holds; the engine itself stays private
   */
  connect(playerId: PlayerId): Transport {
    const transport = new LocalTransport((command) => {
      this.enqueue(playerId, command)
    })

    this.connections.set(playerId, transport)

    transport.deliver({
      kind: 'welcome',
      playerId: playerId,
    })
    transport.deliver({
      kind: 'start',
      config: this.config,
      battlefield: this.battlefield,
    })

    return transport
  }

  /**
   * Detaches a client. Its queued commands are still processed.
   * @param playerId - The player to detach
   */
  disconnect(playerId: PlayerId): void {
    this.connections.delete(playerId)
  }

  start(): void {
    if (this.timer !== null) {
      return
    }

    this.state.status = 'running'
    this.previousMillis = performance.now()
    this.accumulatedSeconds = 0
    this.timer = setInterval(() => {
      this.advance()
    }, TICK_INTERVAL_MILLIS)
  }

  stop(): void {
    if (this.timer !== null) {
      clearInterval(this.timer)
      this.timer = null
    }
  }

  /**
   * Advances the simulation by exactly one tick and broadcasts the result.
   * Public so a replay harness can drive the engine from a recorded command
   * log without involving a timer.
   */
  step(): void {
    const events: MatchEvent[] = []

    this.drain(events)
    this.state.elapsedSeconds += TICK_INTERVAL_SECONDS
    this.ticks += 1

    this.applyIncome()
    this.moveUnits()

    // Combat and node capture run here once docs/specs.md is settled

    this.broadcast(events)
  }

  /**
   * Turns elapsed wall-clock time into whole fixed-size steps.
   * The clock is read only to decide how many steps to run — the simulation
   * itself always advances by exactly TICK_INTERVAL_SECONDS, which is what
   * keeps it deterministic and independent of frame rate and timer jitter.
   */
  private advance(): void {
    const currentMillis = performance.now()

    this.accumulatedSeconds += (currentMillis - this.previousMillis) / MILLIS_PER_SECOND
    this.previousMillis = currentMillis

    while (this.accumulatedSeconds >= TICK_INTERVAL_SECONDS) {
      this.accumulatedSeconds -= TICK_INTERVAL_SECONDS
      this.step()
    }
  }

  private enqueue(playerId: PlayerId, command: Command): void {
    this.queue.push({
      playerId: playerId,
      command: command,
    })
  }

  /**
   * Applies every command queued since the last tick, collecting a rejection
   * event for each one the authority refuses.
   * @param events - Event list for this tick, appended to in place
   */
  private drain(events: MatchEvent[]): void {
    const queued = this.queue.splice(0, this.queue.length)

    for (const entry of queued) {
      const reason = this.validate(entry)

      if (reason !== null) {
        events.push({
          kind: 'rejected',
          playerId: entry.playerId,
          command: entry.command,
          reason: reason,
        })
        continue
      }

      this.apply(entry)
    }
  }

  /**
   * Checks a command against authoritative state.
   * @param entry - The queued command and the player it arrived from
   * @returns Why to refuse it, or null when it is allowed
   */
  private validate(entry: QueuedCommand): RejectionReason | null {
    if (this.state.status !== 'running') {
      return 'match_not_running'
    }

    const player = this.playerFor(entry.playerId)

    if (player === undefined) {
      return 'not_owner'
    }

    if (entry.command.kind === 'deploy_unit') {
      return this.validateDeploy(player, entry.command)
    }

    return null
  }

  /**
   * Checks a deployment against the roster, the player's purse and their own
   * launchers — the three things a client can predict and therefore should
   * already have prevented.
   * @param player - The player the command arrived from
   * @param command - The deployment being checked
   * @returns Why to refuse it, or null when it is allowed
   */
  private validateDeploy(player: Player, command: DeployUnitCommand): RejectionReason | null {
    const stats = this.config.units[command.unitType]

    if (stats === undefined) {
      return 'unknown_unit'
    }

    if (player.resources < stats.deploymentCost) {
      return 'insufficient_resources'
    }

    if (this.launcherAt(command.position, player.id) === undefined) {
      return 'invalid_position'
    }

    return null
  }

  /**
   * The player's own launcher a position falls inside — the only place they
   * may deploy.
   * @param position - Where the unit would appear
   * @param ownerId - The player the launcher must belong to
   * @returns The launcher, or undefined when the position gates nothing of theirs
   */
  private launcherAt(position: Position, ownerId: PlayerId): Launcher | undefined {
    return this.battlefield.launchers.find((launcher) => {
      return launcher.ownerId === ownerId && covers(launcher, position)
    })
  }

  /**
   * The launcher at the far end of a lane — where a unit deployed from the
   * near end is headed.
   * @param lane - The lane in question
   * @param ownerId - The player whose own launcher is at the near end
   * @returns The opposing launcher, or undefined when the lane has none
   */
  private opposingLauncher(lane: number, ownerId: PlayerId): Launcher | undefined {
    return this.battlefield.launchers.find((launcher) => {
      return launcher.lane === lane && launcher.ownerId !== ownerId
    })
  }

  /**
   * Mutates state for a command that passed validation.
   * @param entry - The queued command and the player it arrived from
   */
  private apply(entry: QueuedCommand): void {
    const player = this.playerFor(entry.playerId)

    if (player === undefined) {
      return
    }

    switch (entry.command.kind) {
      case 'deploy_unit': {
        this.deploy(player, entry.command)
        break
      }
      default: {
        // Stopping, targeting, lanes and abilities land with their rules
        break
      }
    }
  }

  /**
   * Charges the deployment cost and puts the unit in the launcher it was
   * dropped on.
   * The unit lands on the launcher's centre rather than under the pointer: a
   * lane is the whole of the choice, so the position in the command only picks
   * which one.
   * @param player - The owner, already known to afford it
   * @param command - The validated deployment
   */
  private deploy(player: Player, command: DeployUnitCommand): void {
    const stats = this.config.units[command.unitType]
    const launcher = this.launcherAt(command.position, player.id)

    if (stats === undefined || launcher === undefined) {
      return
    }

    player.resources -= stats.deploymentCost
    this.state.units.push({
      id: `unit-${this.nextUnitNumber}`,
      type: command.unitType,
      ownerId: player.id,
      lane: launcher.lane,
      position: {
        x: launcher.position.x,
        y: launcher.position.y,
      },
      heading: launcher.heading,
      health: stats.health,
      moving: true,
      targetUnitId: null,
    })
    this.nextUnitNumber += 1
  }

  /**
   * Credits every player the base income earned in one tick.
   * The schedule is docs/specs.md: 2 T/s rising by 0.2 T/s every 30 seconds up
   * to a 3 T/s ceiling. Harvester income waits on a harvester in the roster.
   */
  private applyIncome(): void {
    const steps = Math.floor(this.state.elapsedSeconds / BASE_INCOME_STEP_SECONDS)
    const rate = Math.min(BASE_INCOME_MAX, BASE_INCOME_START + (steps * BASE_INCOME_STEP))

    for (const player of this.state.players) {
      player.resources += rate * TICK_INTERVAL_SECONDS
    }
  }

  /**
   * Advances every moving unit down its lane.
   * A unit runs straight at the launcher gating the far end and halts the
   * moment it touches that launcher's near face. Nothing takes it off the
   * board there yet, so arrivals accumulate against the gate until combat
   * lands (docs/specs.md).
   */
  private moveUnits(): void {
    for (const unit of this.state.units) {
      const stats = this.config.units[unit.type]
      const target = this.opposingLauncher(unit.lane, unit.ownerId)

      if (!unit.moving || stats === undefined || target === undefined) {
        continue
      }

      const advancing = target.position.x > unit.position.x
      const direction = advancing ? 1 : -1
      // Where the unit's leading edge comes to rest against the launcher
      const limit = target.position.x - (direction * ((target.size.width / 2) + stats.size))
      const advanced = unit.position.x + (direction * stats.speed * TICK_INTERVAL_SECONDS)

      if (advancing ? advanced >= limit : advanced <= limit) {
        unit.position.x = limit
        unit.moving = false
        continue
      }

      unit.position.x = advanced
    }
  }

  /**
   * Looks up a player in authoritative state.
   * @param playerId - The player to find
   * @returns The player, or undefined when no such player is in the match
   */
  private playerFor(playerId: PlayerId): Player | undefined {
    return this.state.players.find((candidate) => candidate.id === playerId)
  }

  private broadcast(events: MatchEvent[]): void {
    this.connections.forEach((transport, playerId) => {
      transport.deliver({
        kind: 'update',
        tick: this.ticks,
        state: this.viewFor(playerId),
        events: this.eventsFor(playerId, events),
      })
    })
  }

  /**
   * The slice of state a given player is allowed to see.
   * Identity today, which means randomSeed currently travels to clients and
   * future rolls are predictable — harmless locally, but this is the function
   * that has to strip it before an authority is ever remote. Fog of war
   * (docs/specs.md open questions) lands here too, and nothing else changes:
   * neither the broadcast path nor any client.
   * @param _playerId - The player the snapshot is addressed to
   * @returns The state to send
   */
  private viewFor(_playerId: PlayerId): MatchState {
    return this.state
  }

  /**
   * The events a given player is allowed to see.
   * Every event in the union is currently addressed to one player. When
   * broadcast events arrive this needs a switch on kind rather than a
   * playerId comparison.
   * @param playerId - The player the events are addressed to
   * @param events - Every event produced this tick
   * @returns The subset to send
   */
  private eventsFor(playerId: PlayerId, events: MatchEvent[]): MatchEvent[] {
    return events.filter((event) => event.playerId === playerId)
  }
}
