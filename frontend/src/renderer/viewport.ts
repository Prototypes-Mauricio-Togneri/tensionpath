import type {Position} from '@/domain/entities/position'
import type {Size} from '@/domain/entities/size'
import {FIELD_PADDING} from '@/renderer/constants'

/**
 * Maps battlefield units to canvas pixels, and back for pointer input.
 * The battlefield's dimensions come from the rules, so this is the one place
 * that knows about the screen: it fits the field into whatever size the canvas
 * element is given, preserving the aspect ratio and centring the remainder.
 */
export class Viewport {
  private readonly canvas: HTMLCanvasElement
  private battlefieldSize: Size = {
    width: 1,
    height: 1,
  }
  private scale = 1 // CSS pixels per battlefield unit
  private originX = 0 // CSS pixels between the canvas edge and battlefield x = 0
  private originY = 0 // CSS pixels between the canvas edge and battlefield y = 0
  private widthPixels = 0 // Canvas width in CSS pixels
  private heightPixels = 0 // Canvas height in CSS pixels

  constructor(canvas: HTMLCanvasElement) {
    this.canvas = canvas
  }

  get width(): number {
    return this.widthPixels
  }

  get height(): number {
    return this.heightPixels
  }

  /**
   * Ratio between the drawing buffer and the CSS box, so a caller can scale
   * the context once and then work entirely in CSS pixels.
   */
  get pixelRatio(): number {
    return this.widthPixels > 0 ? this.canvas.width / this.widthPixels : 1
  }

  /**
   * Adopts the battlefield that arrived in the start message.
   * @param size - Extent of the field in battlefield units
   */
  setBattlefieldSize(size: Size): void {
    this.battlefieldSize = size
    this.fit()
  }

  /**
   * Matches the drawing buffer to the element's current size and device pixel
   * ratio, so the canvas stays sharp on any display.
   * @returns True when the buffer had to change
   */
  resize(): boolean {
    const bufferWidth = Math.round(this.canvas.clientWidth * window.devicePixelRatio)
    const bufferHeight = Math.round(this.canvas.clientHeight * window.devicePixelRatio)
    const unchanged = this.canvas.width === bufferWidth && this.canvas.height === bufferHeight

    this.widthPixels = this.canvas.clientWidth
    this.heightPixels = this.canvas.clientHeight

    if (unchanged) {
      return false
    }

    this.canvas.width = bufferWidth
    this.canvas.height = bufferHeight
    this.fit()

    return true
  }

  /**
   * Horizontal battlefield coordinate to CSS pixels.
   * @param x - Position along the field
   * @returns Distance from the canvas' left edge
   */
  toCanvasX(x: number): number {
    return this.originX + (x * this.scale)
  }

  /**
   * Vertical battlefield coordinate to CSS pixels.
   * @param y - Position across the field
   * @returns Distance from the canvas' top edge
   */
  toCanvasY(y: number): number {
    return this.originY + (y * this.scale)
  }

  /**
   * Battlefield distance to CSS pixels.
   * @param units - Length in battlefield units
   * @returns The same length on screen
   */
  toCanvasLength(units: number): number {
    return units * this.scale
  }

  /**
   * Pointer coordinates to a point on the battlefield.
   * The result can fall outside the field: the canvas is letterboxed, so the
   * caller still has to decide whether the point is playable.
   * @param clientX - Pointer x in viewport coordinates
   * @param clientY - Pointer y in viewport coordinates
   * @returns The corresponding battlefield position
   */
  toBattlefield(clientX: number, clientY: number): Position {
    const bounds = this.canvas.getBoundingClientRect()

    return {
      x: (clientX - bounds.left - this.originX) / this.scale,
      y: (clientY - bounds.top - this.originY) / this.scale,
    }
  }

  /**
   * Recomputes scale and origin so the padded battlefield fits the canvas.
   */
  private fit(): void {
    const paddedWidth = this.battlefieldSize.width + (FIELD_PADDING * 2)
    const paddedHeight = this.battlefieldSize.height + (FIELD_PADDING * 2)

    this.scale = Math.min(this.widthPixels / paddedWidth, this.heightPixels / paddedHeight)
    this.originX = (this.widthPixels - (this.battlefieldSize.width * this.scale)) / 2
    this.originY = (this.heightPixels - (this.battlefieldSize.height * this.scale)) / 2
  }
}
