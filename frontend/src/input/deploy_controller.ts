import type {Battlefield} from '@/domain/entities/battlefield'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {Position} from '@/domain/entities/position'
import type {Transport} from '@/domain/protocol/transport'
import type {UnitType} from '@/domain/types/unit_type'
import type {DeployPreview} from '@/renderer/match_renderer'
import type {Viewport} from '@/renderer/viewport'

/** PointerEvent.button for the primary button, the only one that deploys */
const PRIMARY_BUTTON = 0

/**
 * Everything the controller needs to translate a drag into a command.
 */
export type DeployControllerOptions = {
  canvas: HTMLCanvasElement
  viewport: Viewport
  transport: Transport
  onPreview: (preview: DeployPreview | null) => void
  onDragChange: (unitType: UnitType | null) => void
}

/**
 * A unit being carried from the roster to the field.
 */
type Drag = {
  unitType: UnitType
  source: HTMLElement // The card the pointer was captured on
  pointerId: number
}

/**
 * Turns a drag from the roster onto the battlefield into a deploy command.
 * Holds a Transport and nothing else of the authority: it maps a pointer to a
 * battlefield position, previews the placement, and sends on release. Whether
 * the deployment actually happens is the engine's answer, arriving in a later
 * snapshot.
 */
export class DeployController {
  private readonly canvas: HTMLCanvasElement
  private readonly viewport: Viewport
  private readonly transport: Transport
  private readonly onPreview: (preview: DeployPreview | null) => void
  private readonly onDragChange: (unitType: UnitType | null) => void
  private config: MatchConfig | null = null
  private battlefield: Battlefield | null = null
  private drag: Drag | null = null

  constructor(options: DeployControllerOptions) {
    this.canvas = options.canvas
    this.viewport = options.viewport
    this.transport = options.transport
    this.onPreview = options.onPreview
    this.onDragChange = options.onDragChange
  }

  /**
   * Adopts the immutable half of the match.
   * @param config - Tuning from the start message
   * @param battlefield - Layout from the start message
   */
  applyStart(config: MatchConfig, battlefield: Battlefield): void {
    this.config = config
    this.battlefield = battlefield
  }

  /**
   * Picks a unit up, called by the roster when a card takes a pointer down.
   * The pointer is captured on the card rather than tracked on the canvas, so
   * the drag keeps reporting once it leaves the rail and cannot be lost to
   * whatever else the pointer passes over on the way to the field.
   * @param unitType - The card that was pressed
   * @param source - The card element, which captures the pointer
   * @param event - The pointer down that started the drag
   */
  beginDrag(unitType: UnitType, source: HTMLElement, event: PointerEvent): void {
    // Secondary buttons are left alone: they belong to whatever context menu
    // or camera control lands later, not to deployment
    if (event.button !== PRIMARY_BUTTON) {
      return
    }

    // One pointer carries one unit; a second cancels the first rather than
    // leaving a drag nothing will ever release
    this.endDrag()

    this.drag = {
      unitType: unitType,
      source: source,
      pointerId: event.pointerId,
    }

    source.setPointerCapture(event.pointerId)
    source.addEventListener('pointermove', this.handlePointerMove)
    source.addEventListener('pointerup', this.handlePointerUp)
    source.addEventListener('pointercancel', this.handlePointerCancel)
    this.onDragChange(unitType)
  }

  dispose(): void {
    this.endDrag()
  }

  private readonly handlePointerMove = (event: PointerEvent): void => {
    if (event.pointerId !== this.drag?.pointerId) {
      return
    }

    this.onPreview(this.previewAt(event))
  }

  private readonly handlePointerUp = (event: PointerEvent): void => {
    const drag = this.drag

    if (drag === null || event.pointerId !== drag.pointerId) {
      return
    }

    const preview = this.previewAt(event)

    // A release anywhere else simply puts the unit back: the preview already
    // showed the refusal under the pointer before the player let go
    if (preview !== null && preview.valid) {
      this.transport.send({
        kind: 'deploy_unit',
        unitType: drag.unitType,
        position: preview.position,
      })
    }

    this.endDrag()
  }

  private readonly handlePointerCancel = (event: PointerEvent): void => {
    if (event.pointerId !== this.drag?.pointerId) {
      return
    }

    this.endDrag()
  }

  /**
   * Puts the carried unit down without deploying it and clears the preview.
   */
  private endDrag(): void {
    const drag = this.drag

    if (drag === null) {
      return
    }

    this.drag = null
    drag.source.removeEventListener('pointermove', this.handlePointerMove)
    drag.source.removeEventListener('pointerup', this.handlePointerUp)
    drag.source.removeEventListener('pointercancel', this.handlePointerCancel)

    if (drag.source.hasPointerCapture(drag.pointerId)) {
      drag.source.releasePointerCapture(drag.pointerId)
    }

    this.onPreview(null)
    this.onDragChange(null)
  }

  /**
   * The placement the pointer is currently indicating.
   * @param event - The pointer event being handled
   * @returns The preview, or null when the pointer is not over the field
   */
  private previewAt(event: PointerEvent): DeployPreview | null {
    const config = this.config
    const drag = this.drag

    if (config === null || drag === null || !this.isOverField(event)) {
      return null
    }

    const stats = config.units[drag.unitType]

    if (stats === undefined) {
      return null
    }

    const position = this.viewport.toBattlefield(event.clientX, event.clientY)

    return {
      position: position,
      radius: stats.size,
      valid: this.isDeployable(position, config.deployMargin),
    }
  }

  /**
   * Whether the pointer is over the battlefield at all.
   * Capture keeps every event coming from the card the drag started on, so the
   * canvas cannot report entry and exit for itself.
   * @param event - The pointer event being handled
   * @returns True when the pointer is inside the canvas
   */
  private isOverField(event: PointerEvent): boolean {
    const bounds = this.canvas.getBoundingClientRect()
    const insideX = event.clientX >= bounds.left && event.clientX <= bounds.right
    const insideY = event.clientY >= bounds.top && event.clientY <= bounds.bottom

    return insideX && insideY
  }

  /**
   * Mirrors the authority's placement rule so a refusal shows under the
   * pointer instead of arriving as a rejected event. The margin travels in
   * MatchConfig for exactly this: the client predicts what it can, and the
   * engine still decides.
   * @param position - Where the unit would land
   * @param margin - Unplayable strip along each edge, in battlefield units
   * @returns True when the placement is worth sending
   */
  private isDeployable(position: Position, margin: number): boolean {
    const battlefield = this.battlefield

    if (battlefield === null) {
      return false
    }

    const insideX = position.x >= margin && position.x <= battlefield.size.width - margin
    const insideY = position.y >= margin && position.y <= battlefield.size.height - margin

    return insideX && insideY
  }
}
