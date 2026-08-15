import type {NodeType} from '@/domain/types/node_type'

/**
 * Visual constants for the canvas renderer.
 * Client-owned: the engine's balancing values never reach here and these never
 * reach the engine. Lengths are in battlefield units unless the name says
 * pixels, and alphas apply to the design tokens read in theme.ts.
 */
export const MILLIS_PER_SECOND = 1000

export const TAU = Math.PI * 2

/**
 * Window the frame rate is averaged over, in milliseconds. A per-frame figure
 * jitters far too much to read; this is long enough to settle and short enough
 * that a stall shows while it is still happening.
 */
export const FRAME_RATE_SAMPLE_MILLIS = 500

/** Breathing room around the battlefield so the frame clears the HUD rails */
export const FIELD_PADDING = 4

/* Lanes — the field's only structure, so the stack of them is the frame too */
export const LANE_EDGE_ALPHA = 0.38

/* Launchers */
export const LAUNCHER_FILL_ALPHA = 0.07

export const LAUNCHER_EDGE_ALPHA = 0.8

/* Nodes */
export const NODE_RADIUS_DEFAULT = 2

/**
 * Node footprint by kind. Size is the only thing separating one node from
 * another until docs/specs.md describes how each should read, so it carries
 * importance: objectives are large, pickups small.
 */
export const NODE_RADIUS_BY_TYPE: Record<NodeType, number> = {
  launcher: 2.2,
  platform: 2.2,
  missile: 1.6,
  resources: 1.6,
  obstacle: 2,
  victory: 3.4,
  chest: 1.6,
  resource_generator: 2.6,
  unit_generator: 2.6,
  checkpoint: 2,
}

export const NODE_CORE_FRACTION = 0.32

export const NODE_FILL_ALPHA = 0.1

export const NODE_RING_ALPHA = 0.45

export const NODE_CORE_ALPHA = 0.7

/* Units — the silhouettes themselves live in unit_shapes.ts */
export const UNIT_FILL_ALPHA = 0.35

export const UNIT_HEALTH_BAR_WIDTH = 2.6

export const UNIT_HEALTH_BAR_HEIGHT = 0.5

export const UNIT_HEALTH_BAR_OFFSET = 2.2

export const UNIT_HEALTH_TRACK_ALPHA = 0.25

/* Deployment preview */
export const PREVIEW_ALPHA = 0.55

export const PREVIEW_CROSS_REACH = 1.7 // Multiple of the unit radius

export const PREVIEW_DASH = [
  0.6,
  0.9,
]

/* Line widths, in CSS pixels — kept off the battlefield scale so a hairline
   stays a hairline at any zoom */
export const HAIRLINE_WIDTH = 1

export const LAUNCHER_EDGE_WIDTH = 1.5

export const UNIT_OUTLINE_WIDTH = 1.5
