import type {MatchState} from '@/domain/entities/match_state'
import type {Position} from '@/domain/entities/position'
import type {Unit} from '@/domain/entities/unit'
import type {UnitId} from '@/domain/types/ids'
import {MILLIS_PER_SECOND} from '@/renderer/constants'

/**
 * A unit placed where it should appear this frame, rather than where the last
 * tick left it.
 */
export type InterpolatedUnit = {
  unit: Unit
  position: Position
  heading: number
}

/**
 * Interpolates a rotation the short way round, so a unit turning past ±π does
 * not spin the long way.
 * @param from - Starting angle in radians
 * @param to - Target angle in radians
 * @param alpha - Progress between the two, from 0 to 1
 * @returns The intermediate angle
 */
function interpolateAngle(from: number, to: number, alpha: number): number {
  const delta = Math.atan2(Math.sin(to - from), Math.cos(to - from))

  return from + (delta * alpha)
}

/**
 * A unit drawn exactly where the snapshot puts it.
 * @param unit - The unit to place
 * @returns The unit with no interpolation applied
 */
function placeDirectly(unit: Unit): InterpolatedUnit {
  return {
    unit: unit,
    position: unit.position,
    heading: unit.heading,
  }
}

/**
 * Holds the two most recent snapshots so the renderer can draw between them.
 * The authority ticks well below the display rate, so drawing the newest
 * snapshot on every frame would step visibly. Sampling one tick in the past
 * instead means there are always two known states to interpolate between and
 * never a need to guess ahead of the authority.
 */
export class SnapshotBuffer {
  private previous: MatchState | null = null
  private current: MatchState | null = null
  private previousMillis = 0
  private currentMillis = 0
  private intervalMillis = 0

  get latest(): MatchState | null {
    return this.current
  }

  /**
   * Adopts the snapshot cadence announced in the start message.
   * @param ticksPerSecond - Snapshots the authority sends per second
   */
  setTickRate(ticksPerSecond: number): void {
    this.intervalMillis = MILLIS_PER_SECOND / ticksPerSecond
  }

  /**
   * Records a snapshot, retiring the one before it.
   * @param state - The snapshot as received
   * @param nowMillis - When it arrived
   */
  push(state: MatchState, nowMillis: number): void {
    this.previous = this.current
    this.previousMillis = this.currentMillis
    this.current = state
    this.currentMillis = nowMillis
  }

  /**
   * The units as they should be drawn at a given moment.
   * Units that appeared in the newest snapshot have nothing to interpolate
   * from and are drawn where they were deployed; units that have left it are
   * gone, which is what makes the newest snapshot authoritative on screen too.
   * @param nowMillis - The moment being drawn
   * @returns One entry per unit in the newest snapshot
   */
  sample(nowMillis: number): InterpolatedUnit[] {
    const current = this.current

    if (current === null) {
      return []
    }

    const previous = this.previous
    const span = this.currentMillis - this.previousMillis

    if (previous === null || span <= 0) {
      return current.units.map(placeDirectly)
    }

    const alpha = Math.min(Math.max((nowMillis - this.intervalMillis - this.previousMillis) / span, 0), 1)
    const earlier = new Map<UnitId, Unit>()

    for (const unit of previous.units) {
      earlier.set(unit.id, unit)
    }

    return current.units.map((unit) => {
      const start = earlier.get(unit.id)

      if (start === undefined) {
        return placeDirectly(unit)
      }

      return {
        unit: unit,
        position: {
          x: start.position.x + ((unit.position.x - start.position.x) * alpha),
          y: start.position.y + ((unit.position.y - start.position.y) * alpha),
        },
        heading: interpolateAngle(start.heading, unit.heading, alpha),
      }
    })
  }
}
