import type {Position} from '@/domain/entities/position'
import type {UnitType} from '@/domain/types/unit_type'

/**
 * The silhouette a unit type is recognised by.
 * Each is a closed polygon in unit coordinates — sized to roughly radius 1 and
 * pointing along +x — so whoever draws it only has to scale by the unit's size
 * and rotate by its heading. A shape may reach a little past 1 along the axis
 * it travels, which is how the ranger reads as a needle rather than a dart.
 * One vocabulary serves both the canvas and the roster card, which is the
 * point: the card teaches exactly the outline the player then has to pick out
 * of a lane, and the two can never drift apart.
 *
 * The shapes read as a scale of weight, from the scout's splinter to the
 * bastion's blunt hexagon, so a glance at a lane says what is in it before any
 * label does. Client-owned and purely visual — no balancing value reaches here.
 */
export const UNIT_SHAPES: Record<UnitType, Position[]> = {
  // Splinter — the narrowest thing on the field
  scout: [
    {
      x: 1,
      y: 0,
    },
    {
      x: -0.8,
      y: 0.5,
    },
    {
      x: -0.45,
      y: 0,
    },
    {
      x: -0.8,
      y: -0.5,
    },
  ],
  // Barbed chevron — swept back to a point at either wingtip
  talon: [
    {
      x: 1,
      y: 0,
    },
    {
      x: -0.55,
      y: 0.95,
    },
    {
      x: -0.05,
      y: 0,
    },
    {
      x: -0.55,
      y: -0.95,
    },
  ],
  // Finned needle — long and thin, with the fins set well back; all reach
  ranger: [
    {
      x: 1.3,
      y: 0,
    },
    {
      x: -0.25,
      y: 0.2,
    },
    {
      x: -0.9,
      y: 0.75,
    },
    {
      x: -0.6,
      y: 0,
    },
    {
      x: -0.9,
      y: -0.75,
    },
    {
      x: -0.25,
      y: -0.2,
    },
  ],
  // Blunt-nosed pentagon — it lobs rather than charges, so it has no point
  salvo: [
    {
      x: 0.75,
      y: 0.4,
    },
    {
      x: 0.75,
      y: -0.4,
    },
    {
      x: -0.45,
      y: -0.9,
    },
    {
      x: -0.95,
      y: 0,
    },
    {
      x: -0.45,
      y: 0.9,
    },
  ],
  // Kite — broad across the middle, the first shape that reads as heavy
  lancer: [
    {
      x: 1,
      y: 0,
    },
    {
      x: -0.15,
      y: 0.85,
    },
    {
      x: -0.9,
      y: 0,
    },
    {
      x: -0.15,
      y: -0.85,
    },
  ],
  // Hexagon — no leading point at all; it advances, it does not charge
  bastion: [
    {
      x: 0.5,
      y: 0.8,
    },
    {
      x: 1,
      y: 0,
    },
    {
      x: 0.5,
      y: -0.8,
    },
    {
      x: -0.5,
      y: -0.8,
    },
    {
      x: -1,
      y: 0,
    },
    {
      x: -0.5,
      y: 0.8,
    },
  ],
}

/**
 * Silhouette for a unit type the vocabulary does not cover, so a roster the
 * authority adds still draws as something rather than nothing.
 */
export const UNIT_SHAPE_DEFAULT: Position[] = [
  {
    x: 1,
    y: 0,
  },
  {
    x: -0.7,
    y: 0.75,
  },
  {
    x: -0.7,
    y: -0.75,
  },
]

/**
 * The polygon a unit type is drawn as.
 * @param unitType - The unit being drawn
 * @returns Its silhouette, or the fallback when the vocabulary has none
 */
export function shapeFor(unitType: UnitType): Position[] {
  return UNIT_SHAPES[unitType] ?? UNIT_SHAPE_DEFAULT
}
