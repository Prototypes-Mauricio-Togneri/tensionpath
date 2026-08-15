import type {Battlefield} from '@/domain/entities/battlefield'
import type {Launcher} from '@/domain/entities/launcher'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {LauncherId, PlayerId} from '@/domain/types/ids'
import {BASE_HEALTH, BATTLEFIELD_HEIGHT, BATTLEFIELD_WIDTH, LANE_COUNT, LANE_HEIGHT, LAUNCHER_SIZE, STARTING_RESOURCES, UNIT_ROSTER} from '@/engine/balancing'

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
    units: UNIT_ROSTER,
  }
}

/**
 * Builds one launcher, centred on the lane it gates.
 * The heading is stated here rather than worked out from the launcher's end of
 * the field, so the engine and the renderer read the same number instead of
 * each deriving one.
 * @param id - Identifier, stable for the life of the match
 * @param ownerId - The player who deploys from it
 * @param lane - Lane it gates, counted from the top of the field
 * @param centreX - Distance along the field to the centre of the square
 * @param heading - Direction its units set off in, in radians
 * @returns The launcher
 */
function createLauncher(id: LauncherId, ownerId: PlayerId, lane: number, centreX: number, heading: number): Launcher {
  return {
    id: id,
    ownerId: ownerId,
    lane: lane,
    heading: heading,
    position: {
      x: centreX,
      y: (lane * LANE_HEIGHT) + (LANE_HEIGHT / 2),
    },
    size: {
      width: LAUNCHER_SIZE,
      height: LAUNCHER_SIZE,
    },
  }
}

/**
 * Builds the static battlefield layout sent to clients in the start message.
 * Dimensions come from the rules, never from the viewport.
 * Every lane is gated at both ends, so which side a player deploys from is
 * decided here rather than by a seat number the clients would each have to
 * interpret the same way.
 * The field carries no nodes yet: docs/specs.md lists the kinds a node can be
 * but not where any of them belong, and a placeholder layout only teaches
 * players a shape that is about to change. The node plumbing stays wired end
 * to end, so the real layout is a matter of filling this list.
 * @param leftPlayerId - The player deploying from the left edge
 * @param rightPlayerId - The player deploying from the right edge
 * @returns Layout for a new match
 */
export function createDefaultBattlefield(leftPlayerId: PlayerId, rightPlayerId: PlayerId): Battlefield {
  const launchers: Launcher[] = []

  for (let lane = 0; lane < LANE_COUNT; lane += 1) {
    launchers.push(createLauncher(`launcher-left-${lane}`, leftPlayerId, lane, LAUNCHER_SIZE / 2, 0))
    launchers.push(createLauncher(`launcher-right-${lane}`, rightPlayerId, lane, BATTLEFIELD_WIDTH - (LAUNCHER_SIZE / 2), Math.PI))
  }

  return {
    size: {
      width: BATTLEFIELD_WIDTH,
      height: BATTLEFIELD_HEIGHT,
    },
    laneCount: LANE_COUNT,
    launchers: launchers,
    nodes: [],
  }
}
