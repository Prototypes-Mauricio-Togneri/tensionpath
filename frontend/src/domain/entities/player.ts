import type {PlayerId} from '@/domain/types/ids'

/**
 * A player's mutable standing in the match, replaced wholesale every tick.
 */
export type Player = {
  id: PlayerId
  name: string
  baseHealth: number
  resources: number
}
