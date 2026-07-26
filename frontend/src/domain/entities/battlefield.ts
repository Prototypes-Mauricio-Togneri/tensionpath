import type {BattlefieldNode} from '@/domain/entities/battlefield_node'
import type {Size} from '@/domain/entities/size'

/**
 * Static layout of the battlefield, sent once in the start message.
 * Dimensions are game units decided by the rules, never derived from the
 * viewport — the renderer scales this to the screen, not the other way round.
 */
export type Battlefield = {
  size: Size
  nodes: BattlefieldNode[]
}
