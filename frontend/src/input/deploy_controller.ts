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
 * Everything the controller needs to translate a pointer into a command.
 */
export type DeployControllerOptions = {
  canvas: HTMLCanvasElement
  viewport: Viewport
  transport: Transport
  onPreview: (preview: DeployPreview | null) => void
}

/**
 * Turns pointer activity over the battlefield into deploy commands.
 * Holds a Transport and nothing else of the authority: it maps a pointer to a
 * battlefield position, previews the placement, and sends. Whether the
 * deployment actually happens is the engine's answer, arriving in a later
 * snapshot.
 */
export class DeployController {
  private readonly canvas: HTMLCanvasElement
  private readonly viewport: Viewport
  private readonly transport: Transport
  private readonly onPreview: (preview: DeployPreview | null) => void
  private config: MatchConfig | null = null
  private battlefield: Battlefield | null = null
  private selected: UnitType | null = null

  constructor(options: DeployControllerOptions) {
    this.canvas = options.canvas
    this.viewport = options.viewport
    this.transport = options.transport
    this.onPreview = options.onPreview
    this.canvas.addEventListener('pointermove', this.handlePointerMove)
    this.canvas.addEventListener('pointerdown', this.handlePointerDown)
    this.canvas.addEventListener('pointerleave', this.handlePointerLeave)
  }

  /**
   * The unit the player is holding, or null when nothing is selected.
   */
  set selectedUnitType(unitType: UnitType | null) {
    this.selected = unitType

    if (unitType === null) {
      this.onPreview(null)
    }
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

  dispose(): void {
    this.canvas.removeEventListener('pointermove', this.handlePointerMove)
    this.canvas.removeEventListener('pointerdown', this.handlePointerDown)
    this.canvas.removeEventListener('pointerleave', this.handlePointerLeave)
  }

  private readonly handlePointerMove = (event: PointerEvent): void => {
    this.onPreview(this.previewAt(event))
  }

  private readonly handlePointerLeave = (): void => {
    this.onPreview(null)
  }

  private readonly handlePointerDown = (event: PointerEvent): void => {
    // Secondary buttons are left alone: they belong to whatever context menu
    // or camera control lands later, not to deployment
    if (event.button !== PRIMARY_BUTTON) {
      return
    }

    const preview = this.previewAt(event)
    const unitType = this.selected

    if (preview === null || unitType === null || !preview.valid) {
      return
    }

    this.transport.send({
      kind: 'deploy_unit',
      unitType: unitType,
      position: preview.position,
    })
  }

  /**
   * The placement the pointer is currently indicating.
   * @param event - The pointer event being handled
   * @returns The preview, or null when nothing is being placed
   */
  private previewAt(event: PointerEvent): DeployPreview | null {
    const config = this.config
    const unitType = this.selected

    if (config === null || unitType === null) {
      return null
    }

    const stats = config.units[unitType]

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
