import type {Battlefield} from '@/domain/entities/battlefield'
import type {BattlefieldNode} from '@/domain/entities/battlefield_node'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {NodeId} from '@/domain/types/ids'
import type {NodeType} from '@/domain/types/node_type'
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
 * Places a node on the battlefield.
 * @param id - Identifier the matching NodeState refers to
 * @param type - Kind of node
 * @param x - Horizontal position in battlefield units
 * @param y - Vertical position in battlefield units
 * @returns The static placement record
 */
function createNode(id: NodeId, type: NodeType, x: number, y: number): BattlefieldNode {
  return {
    id: id,
    type: type,
    position: {
      x: x,
      y: y,
    },
  }
}

/**
 * Builds the static battlefield layout sent to clients in the start message.
 * Dimensions come from the rules, never from the viewport.
 * The layout is a placeholder, but deliberately symmetric under a half turn
 * about the centre so neither side is favoured once the rules land.
 * @returns Layout for a new match
 */
export function createDefaultBattlefield(): Battlefield {
  return {
    size: {
      width: BATTLEFIELD_WIDTH,
      height: BATTLEFIELD_HEIGHT,
    },
    nodes: [
      createNode('node-victory-west', 'victory', 6, 30),
      createNode('node-victory-east', 'victory', 94, 30),
      createNode('node-generator-north', 'resource_generator', 25, 15),
      createNode('node-generator-south', 'resource_generator', 75, 45),
      createNode('node-checkpoint-west', 'checkpoint', 35, 30),
      createNode('node-checkpoint-east', 'checkpoint', 65, 30),
      createNode('node-resources-north', 'resources', 50, 12),
      createNode('node-resources-south', 'resources', 50, 48),
      createNode('node-chest-centre', 'chest', 50, 30),
    ],
  }
}
