import type {UnitStats} from '@/domain/entities/unit_stats'
import type {UnitType} from '@/domain/types/unit_type'

/**
 * Immutable tuning for a match, sent once in the start message.
 * Keeping this on the wire rather than in a shared module is what lets the
 * engine own every balancing number while the client still renders costs and
 * ranges — and lets a future server retune without shipping a new client.
 */
export type MatchConfig = {
  baseHealth: number
  startingResources: number
  ticksPerSecond: number // Snapshot cadence; the renderer interpolates over it
  units: Record<UnitType, UnitStats>
}
