import type {BattlefieldNode} from '@/domain/entities/battlefield_node'
import type {Launcher} from '@/domain/entities/launcher'
import type {Size} from '@/domain/entities/size'

/**
 * Static layout of the battlefield, sent once in the start message.
 * Dimensions are game units decided by the rules, never derived from the
 * viewport — the renderer scales this to the screen, not the other way round.
 */
export type Battlefield = {
  size: Size
  laneCount: number // Horizontal lanes the field is divided into, top to bottom
  launchers: Launcher[] // Two per lane, one at each end
  nodes: BattlefieldNode[]
}
