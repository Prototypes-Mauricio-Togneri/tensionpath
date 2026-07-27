import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import {BASE_HEALTH, BATTLEFIELD_HEIGHT, BATTLEFIELD_WIDTH, DEPLOY_MARGIN, STARTING_RESOURCES, UNIT_ROSTER} from '@/engine/balancing'

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
 * @returns Immutable config for a new match
 */
export function createDefaultConfig(): MatchConfig {
  return {
    baseHealth: BASE_HEALTH,
    startingResources: STARTING_RESOURCES,
    ticksPerSecond: TICKS_PER_SECOND,
    deployMargin: DEPLOY_MARGIN,
    units: UNIT_ROSTER,
  }
}

/**
 * Builds the static battlefield layout sent to clients in the start message.
 * Dimensions come from the rules, never from the viewport.
 * The field carries no nodes yet: docs/specs.md lists the kinds a node can be
 * but not where any of them belong, and a placeholder layout only teaches
 * players a shape that is about to change. The node plumbing stays wired end
 * to end, so the real layout is a matter of filling this list.
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
