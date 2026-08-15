/**
 * Opaque identifier aliases used across the protocol.
 * Entities reference each other by id rather than by object reference so that
 * every state snapshot stays serializable (see docs/architecture.md).
 */
export type PlayerId = string

export type UnitId = string

export type NodeId = string

export type LauncherId = string
