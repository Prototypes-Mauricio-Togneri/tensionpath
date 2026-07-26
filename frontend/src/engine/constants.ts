import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import {BASE_HEALTH, BATTLEFIELD_HEIGHT, BATTLEFIELD_WIDTH, STARTING_RESOURCES} from '@/engine/balancing'

export const MILLIS_PER_SECOND = 1000

/**
 * Simulation rate. Deliberately a rate a real server could sustain rather than
 * the display rate: the renderer interpolates between snapshots instead.
 */
export const TICKS_PER_SECOND = 20

export const TICK_INTERVAL_SECONDS = 1 / TICKS_PER_SECOND

export const TICK_INTERVAL_MILLIS = MILLIS_PER_SECOND / TICKS_PER_SECOND

/**
 * Builds the tuning table sent to clients in the start message.
 * The unit table is empty until docs/specs.md defines the roster.
 * @returns Immutable config for a new match
 */
export function createDefaultConfig(): MatchConfig {
  return {
    baseHealth: BASE_HEALTH,
    startingResources: STARTING_RESOURCES,
    units: {},
  }
}

/**
 * Builds the static battlefield layout sent to clients in the start message.
 * Dimensions come from the rules, never from the viewport.
 * @returns Layout for a new match
 */
export function createDefaultBattlefield(): Battlefield {
  return {
    size: {
      width: BATTLEFIELD_WIDTH,
      height: BATTLEFIELD_HEIGHT,
    },
    nodes: [],
  }
}
