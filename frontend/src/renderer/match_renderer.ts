import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {Position} from '@/domain/entities/position'
import type {NodeId, PlayerId} from '@/domain/types/ids'
import {BRACKET_WIDTH, CENTRE_AXIS_ALPHA, CENTRE_AXIS_DASH, FIELD_BRACKET_ALPHA, FIELD_BRACKET_LENGTH, FIELD_EDGE_ALPHA, FRAME_RATE_SAMPLE_MILLIS, GRID_ALPHA, GRID_SPACING, GRID_TICK_ALPHA, GRID_TICK_LENGTH, HAIRLINE_WIDTH, MILLIS_PER_SECOND, NODE_CORE_ALPHA, NODE_CORE_FRACTION, NODE_FILL_ALPHA, NODE_RADIUS_BY_TYPE, NODE_RADIUS_DEFAULT, NODE_RING_ALPHA, PREVIEW_ALPHA, PREVIEW_CROSS_REACH, PREVIEW_DASH, TAU, UNIT_FILL_ALPHA, UNIT_HEALTH_BAR_HEIGHT, UNIT_HEALTH_BAR_OFFSET, UNIT_HEALTH_BAR_WIDTH, UNIT_HEALTH_TRACK_ALPHA, UNIT_NOTCH_DEPTH, UNIT_OUTLINE_WIDTH, UNIT_TAIL_LENGTH, UNIT_TAIL_SPREAD} from '@/renderer/constants'
import type {InterpolatedUnit} from '@/renderer/snapshot_buffer'
import {SnapshotBuffer} from '@/renderer/snapshot_buffer'
import type {RendererTheme} from '@/renderer/theme'
import {readTheme, withAlpha} from '@/renderer/theme'
import {Viewport} from '@/renderer/viewport'

/**
 * The placement a player is lining up but has not committed to.
 * Owned by the input layer and handed here to draw, so the renderer stays a
 * function of state and never decides what the pointer means.
 */
export type DeployPreview = {
  position: Position
  radius: number
  valid: boolean
}

/**
 * Draws the battlefield to a canvas.
 * A client like any other: it sees snapshots and never the engine. The
 * authority ticks at a rate a server could sustain, so every frame is sampled
 * from the two most recent snapshots rather than drawn straight from the
 * newest one.
 */
export class MatchRenderer {
  readonly viewport: Viewport
  private readonly context: CanvasRenderingContext2D | null
  private readonly snapshots = new SnapshotBuffer()
  private readonly theme: RendererTheme
  private readonly observer: ResizeObserver
  private config: MatchConfig | null = null
  private battlefield: Battlefield | null = null
  private localPlayerId: PlayerId | null = null
  private preview: DeployPreview | null = null
  private frame: number | null = null
  private frameRateHandler: ((framesPerSecond: number) => void) | null = null
  private sampleStartMillis = 0 // Timestamp the open frame rate sample began at
  private sampledFrames = 0

  constructor(canvas: HTMLCanvasElement) {
    this.context = canvas.getContext('2d')
    this.viewport = new Viewport(canvas)
    this.theme = readTheme()
    this.observer = new ResizeObserver(() => {
      this.viewport.resize()
    })
    this.observer.observe(canvas)
  }

  /**
   * Identifies the player this client speaks for, which is what turns an
   * owner id into an ally or an enemy colour.
   */
  set playerId(playerId: PlayerId) {
    this.localPlayerId = playerId
  }

  /**
   * The placement to outline under the pointer, or null to clear it.
   */
  set deployPreview(preview: DeployPreview | null) {
    this.preview = preview
  }

  /**
   * Receives the averaged frame rate, or null to stop reporting it. The rAF
   * loop is the only thing that knows how often a frame actually lands, so
   * the readout is measured here and displayed elsewhere.
   */
  set onFrameRate(handler: ((framesPerSecond: number) => void) | null) {
    this.frameRateHandler = handler
  }

  /**
   * Adopts the immutable half of the match.
   * @param config - Tuning from the start message
   * @param battlefield - Layout from the start message
   */
  applyStart(config: MatchConfig, battlefield: Battlefield): void {
    this.config = config
    this.battlefield = battlefield
    this.snapshots.setTickRate(config.ticksPerSecond)
    this.viewport.resize()
    this.viewport.setBattlefieldSize(battlefield.size)
  }

  /**
   * Records a snapshot to draw from.
   * @param state - The tick as received
   */
  applyUpdate(state: MatchState): void {
    this.snapshots.push(state, performance.now())
  }

  start(): void {
    if (this.frame === null) {
      this.schedule()
    }
  }

  dispose(): void {
    if (this.frame !== null) {
      cancelAnimationFrame(this.frame)
      this.frame = null
    }

    this.observer.disconnect()
  }

  private schedule(): void {
    this.frame = requestAnimationFrame((nowMillis) => {
      this.sampleFrameRate(nowMillis)
      this.draw(nowMillis)
      this.schedule()
    })
  }

  /**
   * Counts frames and reports the average once the sample window closes.
   * @param nowMillis - Frame timestamp
   */
  private sampleFrameRate(nowMillis: number): void {
    // The first frame only opens the window: it has no interval behind it
    if (this.sampleStartMillis === 0) {
      this.sampleStartMillis = nowMillis

      return
    }

    this.sampledFrames += 1

    const elapsedMillis = nowMillis - this.sampleStartMillis

    if (elapsedMillis < FRAME_RATE_SAMPLE_MILLIS) {
      return
    }

    this.frameRateHandler?.(Math.round((this.sampledFrames * MILLIS_PER_SECOND) / elapsedMillis))
    this.sampleStartMillis = nowMillis
    this.sampledFrames = 0
  }

  /**
   * Paints one frame.
   * @param nowMillis - Frame timestamp, used to sample between snapshots
   */
  private draw(nowMillis: number): void {
    const ctx = this.context
    const battlefield = this.battlefield
    const state = this.snapshots.latest

    if (ctx === null || battlefield === null) {
      return
    }

    const ratio = this.viewport.pixelRatio

    ctx.setTransform(ratio, 0, 0, ratio, 0, 0)
    ctx.fillStyle = this.theme.background
    ctx.fillRect(0, 0, this.viewport.width, this.viewport.height)

    this.drawGrid(ctx, battlefield)
    this.drawFrame(ctx, battlefield)

    if (state !== null) {
      this.drawNodes(ctx, battlefield, state)
    }

    this.drawPreview(ctx)
    this.drawUnits(ctx, this.snapshots.sample(nowMillis))
  }

  /**
   * Survey lines with a tick cross at every intersection — a reference for
   * reading distance off the field, not decoration.
   * @param ctx - Target context, already scaled to CSS pixels
   * @param battlefield - Layout being drawn
   */
  private drawGrid(ctx: CanvasRenderingContext2D, battlefield: Battlefield): void {
    const width = battlefield.size.width
    const height = battlefield.size.height

    ctx.lineWidth = HAIRLINE_WIDTH
    ctx.strokeStyle = withAlpha(this.theme.textRgb, GRID_ALPHA)
    ctx.beginPath()

    for (let x = GRID_SPACING; x < width; x += GRID_SPACING) {
      ctx.moveTo(this.viewport.toCanvasX(x), this.viewport.toCanvasY(0))
      ctx.lineTo(this.viewport.toCanvasX(x), this.viewport.toCanvasY(height))
    }

    for (let y = GRID_SPACING; y < height; y += GRID_SPACING) {
      ctx.moveTo(this.viewport.toCanvasX(0), this.viewport.toCanvasY(y))
      ctx.lineTo(this.viewport.toCanvasX(width), this.viewport.toCanvasY(y))
    }

    ctx.stroke()

    const reach = this.viewport.toCanvasLength(GRID_TICK_LENGTH / 2)

    ctx.strokeStyle = withAlpha(this.theme.textRgb, GRID_TICK_ALPHA)
    ctx.beginPath()

    for (let x = GRID_SPACING; x < width; x += GRID_SPACING) {
      for (let y = GRID_SPACING; y < height; y += GRID_SPACING) {
        const canvasX = this.viewport.toCanvasX(x)
        const canvasY = this.viewport.toCanvasY(y)

        ctx.moveTo(canvasX - reach, canvasY)
        ctx.lineTo(canvasX + reach, canvasY)
        ctx.moveTo(canvasX, canvasY - reach)
        ctx.lineTo(canvasX, canvasY + reach)
      }
    }

    ctx.stroke()
  }

  /**
   * The field edge, corner brackets and the centre axis the two fronts meet on.
   * @param ctx - Target context, already scaled to CSS pixels
   * @param battlefield - Layout being drawn
   */
  private drawFrame(ctx: CanvasRenderingContext2D, battlefield: Battlefield): void {
    const left = this.viewport.toCanvasX(0)
    const right = this.viewport.toCanvasX(battlefield.size.width)
    const top = this.viewport.toCanvasY(0)
    const bottom = this.viewport.toCanvasY(battlefield.size.height)

    ctx.lineWidth = HAIRLINE_WIDTH
    ctx.strokeStyle = withAlpha(this.theme.textRgb, FIELD_EDGE_ALPHA)
    ctx.strokeRect(left, top, right - left, bottom - top)

    ctx.setLineDash(CENTRE_AXIS_DASH.map((segment) => this.viewport.toCanvasLength(segment)))
    ctx.strokeStyle = withAlpha(this.theme.accentRgb, CENTRE_AXIS_ALPHA)
    ctx.beginPath()
    ctx.moveTo(this.viewport.toCanvasX(battlefield.size.width / 2), top)
    ctx.lineTo(this.viewport.toCanvasX(battlefield.size.width / 2), bottom)
    ctx.stroke()
    ctx.setLineDash([])

    const bracket = this.viewport.toCanvasLength(FIELD_BRACKET_LENGTH)

    ctx.lineWidth = BRACKET_WIDTH
    ctx.strokeStyle = withAlpha(this.theme.accentRgb, FIELD_BRACKET_ALPHA)
    ctx.beginPath()
    ctx.moveTo(left, top + bracket)
    ctx.lineTo(left, top)
    ctx.lineTo(left + bracket, top)
    ctx.moveTo(right - bracket, top)
    ctx.lineTo(right, top)
    ctx.lineTo(right, top + bracket)
    ctx.moveTo(right, bottom - bracket)
    ctx.lineTo(right, bottom)
    ctx.lineTo(right - bracket, bottom)
    ctx.moveTo(left + bracket, bottom)
    ctx.lineTo(left, bottom)
    ctx.lineTo(left, bottom - bracket)
    ctx.stroke()
  }

  /**
   * Nodes as owned rings — size says what kind of node it is, colour says
   * whose it is.
   * @param ctx - Target context, already scaled to CSS pixels
   * @param battlefield - Static placement of every node
   * @param state - Snapshot holding current ownership
   */
  private drawNodes(ctx: CanvasRenderingContext2D, battlefield: Battlefield, state: MatchState): void {
    const owners = new Map<NodeId, PlayerId | null>()

    for (const node of state.nodes) {
      owners.set(node.id, node.ownerId)
    }

    for (const node of battlefield.nodes) {
      const triplet = this.factionTriplet(owners.get(node.id) ?? null)
      const canvasX = this.viewport.toCanvasX(node.position.x)
      const canvasY = this.viewport.toCanvasY(node.position.y)
      const radius = this.viewport.toCanvasLength(NODE_RADIUS_BY_TYPE[node.type] ?? NODE_RADIUS_DEFAULT)

      ctx.lineWidth = HAIRLINE_WIDTH
      ctx.fillStyle = withAlpha(triplet, NODE_FILL_ALPHA)
      ctx.strokeStyle = withAlpha(triplet, NODE_RING_ALPHA)
      ctx.beginPath()
      ctx.arc(canvasX, canvasY, radius, 0, TAU)
      ctx.fill()
      ctx.stroke()

      ctx.fillStyle = withAlpha(triplet, NODE_CORE_ALPHA)
      ctx.beginPath()
      ctx.arc(canvasX, canvasY, radius * NODE_CORE_FRACTION, 0, TAU)
      ctx.fill()
    }
  }

  /**
   * Units as darts pointing where they are headed, with a health bar only once
   * they have been hurt — a full bar over every unit would be noise.
   * @param ctx - Target context, already scaled to CSS pixels
   * @param units - Units sampled for this frame
   */
  private drawUnits(ctx: CanvasRenderingContext2D, units: InterpolatedUnit[]): void {
    const config = this.config

    if (config === null) {
      return
    }

    for (const rendered of units) {
      const stats = config.units[rendered.unit.type]

      if (stats === undefined) {
        continue
      }

      const triplet = this.factionTriplet(rendered.unit.ownerId)
      const canvasX = this.viewport.toCanvasX(rendered.position.x)
      const canvasY = this.viewport.toCanvasY(rendered.position.y)
      const radius = this.viewport.toCanvasLength(stats.size)

      ctx.save()
      ctx.translate(canvasX, canvasY)
      ctx.rotate(rendered.heading)
      ctx.beginPath()
      ctx.moveTo(radius, 0)
      ctx.lineTo(-radius * UNIT_TAIL_LENGTH, radius * UNIT_TAIL_SPREAD)
      ctx.lineTo(-radius * UNIT_NOTCH_DEPTH, 0)
      ctx.lineTo(-radius * UNIT_TAIL_LENGTH, -radius * UNIT_TAIL_SPREAD)
      ctx.closePath()
      ctx.fillStyle = withAlpha(triplet, UNIT_FILL_ALPHA)
      ctx.fill()
      ctx.lineWidth = UNIT_OUTLINE_WIDTH
      ctx.strokeStyle = withAlpha(triplet, 1)
      ctx.stroke()
      ctx.restore()

      if (rendered.unit.health < stats.health) {
        this.drawHealthBar(ctx, canvasX, canvasY, triplet, rendered.unit.health / stats.health)
      }
    }
  }

  /**
   * A short bar above a wounded unit.
   * @param ctx - Target context, already scaled to CSS pixels
   * @param canvasX - Unit centre in CSS pixels
   * @param canvasY - Unit centre in CSS pixels
   * @param triplet - Faction colour channels
   * @param fraction - Health remaining, from 0 to 1
   */
  private drawHealthBar(ctx: CanvasRenderingContext2D, canvasX: number, canvasY: number, triplet: string, fraction: number): void {
    const width = this.viewport.toCanvasLength(UNIT_HEALTH_BAR_WIDTH)
    const height = this.viewport.toCanvasLength(UNIT_HEALTH_BAR_HEIGHT)
    const left = canvasX - (width / 2)
    const top = canvasY - this.viewport.toCanvasLength(UNIT_HEALTH_BAR_OFFSET)

    ctx.fillStyle = withAlpha(this.theme.textRgb, UNIT_HEALTH_TRACK_ALPHA)
    ctx.fillRect(left, top, width, height)
    ctx.fillStyle = withAlpha(triplet, 1)
    ctx.fillRect(left, top, width * fraction, height)
  }

  /**
   * The footprint and crosshair for a placement being lined up.
   * @param ctx - Target context, already scaled to CSS pixels
   */
  private drawPreview(ctx: CanvasRenderingContext2D): void {
    const preview = this.preview

    if (preview === null) {
      return
    }

    const canvasX = this.viewport.toCanvasX(preview.position.x)
    const canvasY = this.viewport.toCanvasY(preview.position.y)
    const radius = this.viewport.toCanvasLength(preview.radius)
    const reach = radius * PREVIEW_CROSS_REACH
    const triplet = preview.valid ? this.theme.allyRgb : this.theme.enemyRgb

    ctx.lineWidth = HAIRLINE_WIDTH
    ctx.strokeStyle = withAlpha(triplet, PREVIEW_ALPHA)
    ctx.setLineDash(PREVIEW_DASH.map((segment) => this.viewport.toCanvasLength(segment)))
    ctx.beginPath()
    ctx.arc(canvasX, canvasY, radius, 0, TAU)
    ctx.stroke()
    ctx.setLineDash([])

    ctx.beginPath()
    ctx.moveTo(canvasX - reach, canvasY)
    ctx.lineTo(canvasX + reach, canvasY)
    ctx.moveTo(canvasX, canvasY - reach)
    ctx.lineTo(canvasX, canvasY + reach)
    ctx.stroke()
  }

  /**
   * Colour channels for whoever owns a thing.
   * Ally and enemy mean ownership and nothing else (docs/ui.md), so anything
   * unowned falls back to the neutral text colour.
   * @param ownerId - The owning player, or null when unowned
   * @returns The design token channels to draw with
   */
  private factionTriplet(ownerId: PlayerId | null): string {
    if (ownerId === null) {
      return this.theme.textRgb
    }

    return ownerId === this.localPlayerId ? this.theme.allyRgb : this.theme.enemyRgb
  }
}
