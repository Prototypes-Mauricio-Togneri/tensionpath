import type {Position} from '@/domain/entities/position'
import type {NodeId, PlayerId} from '@/domain/types/ids'
import type {NodeType} from '@/domain/types/node_type'

/**
 * A node placed on the battlefield.
 * Placement is static and arrives in the start message; the mutable part
 * (ownership, depletion) travels in each snapshot as NodeState.
 */
export type BattlefieldNode = {
  id: NodeId
  type: NodeType
  position: Position
}

/**
 * The mutable part of a node, replaced wholesale every tick.
 */
export type NodeState = {
  id: NodeId
  ownerId: PlayerId | null
  depleted: boolean
}
