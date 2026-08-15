import type {Position} from '@/domain/entities/position'
import type {Size} from '@/domain/entities/size'
import type {LauncherId, PlayerId} from '@/domain/types/ids'

/**
 * The gate at one end of a lane: the only place its owner may deploy, and the
 * point an enemy unit advancing down that lane is heading for.
 * Distinct from a BattlefieldNode, which is a map feature that changes hands —
 * a launcher is structural, belongs to one side from the whistle, and carries
 * its own extent so neither the engine nor the renderer has to reconstruct the
 * rectangle from the lane count.
 */
export type Launcher = {
  id: LauncherId
  ownerId: PlayerId
  lane: number // Index of the lane it gates, counted from the top of the field
  heading: number // Direction its units set off in, in radians; 0 points along +x
  position: Position // Centre of the gate
  size: Size
}
