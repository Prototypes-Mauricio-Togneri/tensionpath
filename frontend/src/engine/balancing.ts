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

/**
 * The field is a stack of lanes and nothing else: a unit is deployed into one,
 * travels down it, and never leaves it. The height follows from the lanes
 * rather than the other way round, so a lane is always a whole number of
 * battlefield units and the two rows never have to share a rounded remainder.
 */
export const LANE_COUNT = 7

export const LANE_HEIGHT = 8

export const BATTLEFIELD_HEIGHT = LANE_COUNT * LANE_HEIGHT

/**
 * A launcher is a square the height of its lane, flush against the field edge.
 * Keeping it square means the corridor a unit crosses is the same length in
 * every lane.
 */
export const LAUNCHER_SIZE = LANE_HEIGHT

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
 * Placeholder roster of six contrasting units — enough to exercise deployment,
 * the economy and the renderer. Each is a different reason to spend rather than
 * six points on one power curve, and each is best at exactly one thing: the
 * scout is speed, the talon is a single hard hit, the ranger is reach, the
 * salvo is splash from further out than anything can answer, the lancer is
 * weight, the bastion is the wall that soaks and barely hits back.
 * docs/specs.md defines the attributes a unit has but not the roster itself, so
 * this is replaced wholesale once it does.
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
  talon: {
    deploymentCost: 35,
    health: 55,
    attackType: 'kinetic',
    damage: 12,
    damageEffect: 'single',
    armorType: 'light',
    visibilityRange: 14,
    attackRange: 5,
    size: 1.2,
    speed: 5.5,
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
  salvo: {
    deploymentCost: 45,
    health: 60,
    attackType: 'kinetic',
    damage: 10,
    damageEffect: 'splash',
    armorType: 'light',
    visibilityRange: 16,
    attackRange: 18,
    size: 1.6,
    speed: 2.5,
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
  bastion: {
    deploymentCost: 60,
    health: 220,
    attackType: 'kinetic',
    damage: 6,
    damageEffect: 'single',
    armorType: 'heavy',
    visibilityRange: 10,
    attackRange: 4,
    size: 1.9,
    speed: 2,
  },
}
