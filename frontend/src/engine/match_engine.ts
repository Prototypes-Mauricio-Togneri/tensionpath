import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {Command} from '@/domain/protocol/command'
import type {MatchEvent} from '@/domain/protocol/message'
import type {Transport} from '@/domain/protocol/transport'
import type {PlayerId} from '@/domain/types/ids'
import type {RejectionReason} from '@/domain/types/rejection_reason'
import {MILLIS_PER_SECOND, TICK_INTERVAL_MILLIS, TICK_INTERVAL_SECONDS} from '@/engine/constants'
import {LocalTransport} from '@/engine/local_transport'

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

    // Movement, combat and economy run here once docs/specs.md is settled

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
      }

      // Accepted commands mutate state here once the rules land
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

    const player = this.state.players.find((candidate) => candidate.id === entry.playerId)

    if (player === undefined) {
      return 'not_owner'
    }

    return null
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
