import type {UnitStats} from '@/domain/entities/unit_stats'
import type {UnitType} from '@/domain/types/unit_type'

/**
 * Numeric balancing values. Engine-owned and never imported by the client —
 * the subset a client needs travels in the start message as MatchConfig.
 * Placeholders until docs/specs.md settles the corresponding rules.
 */
export const BASE_HEALTH = 100

/**
 * Enough in hand to afford the cheapest unit at the whistle. Without it the
 * opening of every match is spent watching an empty field wait for income.
 */
export const STARTING_RESOURCES = 30

export const BATTLEFIELD_WIDTH = 100

export const BATTLEFIELD_HEIGHT = 60

/**
 * Base income as specified in docs/specs.md: 2 T/s at the start, gaining
 * 0.2 T/s every 30 seconds up to 3 T/s. Harvester income is not modelled yet —
 * it waits on a harvester existing in the roster.
 */
export const BASE_INCOME_START = 2

export const BASE_INCOME_STEP = 0.2

export const BASE_INCOME_STEP_SECONDS = 30

export const BASE_INCOME_MAX = 3

/**
 * How far from the battlefield edge a unit may be deployed, in battlefield
 * units. Placeholder: docs/specs.md does not restrict deployment yet.
 */
export const DEPLOY_MARGIN = 3

/**
 * Placeholder roster of three contrasting units — enough to exercise
 * deployment, the economy and the renderer. Each is a different reason to
 * spend rather than three points on one power curve: the scout is speed, the
 * ranger is reach, the lancer is weight. docs/specs.md defines the attributes
 * a unit has but not the roster itself, so this is replaced wholesale once it
 * does.
 */
export const UNIT_ROSTER: Record<UnitType, UnitStats> = {
  scout: {
    deploymentCost: 30,
    health: 40,
    attackType: 'kinetic',
    damage: 4,
    damageEffect: 'single',
    armorType: 'light',
    visibilityRange: 18,
    attackRange: 6,
    size: 1.1,
    speed: 6,
  },
  ranger: {
    deploymentCost: 40,
    health: 70,
    attackType: 'kinetic',
    damage: 8,
    damageEffect: 'single',
    armorType: 'medium',
    visibilityRange: 22,
    attackRange: 14,
    size: 1.4,
    speed: 4.5,
  },
  lancer: {
    deploymentCost: 50,
    health: 120,
    attackType: 'kinetic',
    damage: 14,
    damageEffect: 'splash',
    armorType: 'heavy',
    visibilityRange: 12,
    attackRange: 9,
    size: 1.8,
    speed: 3,
  },
}
