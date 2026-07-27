import type {ArmorType} from '@/domain/types/armor_type'
import type {AttackType} from '@/domain/types/attack_type'
import type {DamageEffect} from '@/domain/types/damage_effect'

/**
 * Static attributes of a unit type, as listed in docs/specs.md.
 * Sent once in the start message so the client can render costs, ranges and
 * sizes without importing the engine's balancing values.
 */
export type UnitStats = {
  deploymentCost: number
  health: number
  attackType: AttackType
  damage: number
  damageEffect: DamageEffect
  armorType: ArmorType
  visibilityRange: number
  attackRange: number
  size: number // Radius in battlefield units
  speed: number // Battlefield units per second
}
