import type {Position} from '@/domain/entities/position'
import type {PlayerId, UnitId} from '@/domain/types/ids'
import type {UnitType} from '@/domain/types/unit_type'

/**
 * A unit on the battlefield, as seen in a snapshot.
 * Plain data with no methods: the rules that move and damage a unit are free
 * functions in src/engine/ that take this and the surrounding state. Targets
 * are referenced by id, never by object reference, so the value stays
 * serializable.
 */
export type Unit = {
  id: UnitId
  type: UnitType
  ownerId: PlayerId
  position: Position
  heading: number // Facing in radians; 0 points along +x
  health: number
  moving: boolean
  targetUnitId: UnitId | null
}
