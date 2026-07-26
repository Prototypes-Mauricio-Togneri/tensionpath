import type {NodeState} from '@/domain/entities/battlefield_node'
import type {Player} from '@/domain/entities/player'
import type {Unit} from '@/domain/entities/unit'
import type {MatchStatus} from '@/domain/types/match_status'

/**
 * The complete mutable state of a match — the engine's single source of truth
 * and, unchanged, the payload the client receives each tick.
 * There is no separate DTO layer: this type is already wire-safe plain data,
 * so it must never grow a Map, Set, Date, class instance or undefined field.
 */
export type MatchState = {
  status: MatchStatus
  elapsedSeconds: number
  players: Player[]
  units: Unit[]
  nodes: NodeState[]
  randomSeed: number // Advanced by nextRandom; keeps the sim replayable
}
