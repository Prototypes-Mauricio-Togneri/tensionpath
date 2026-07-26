/**
 * Why the engine refused a command.
 * The client greys out what it can predict from its own snapshot; this covers
 * the cases that still reach the authority — races, stale state, cooldowns.
 */
export type RejectionReason =
  | 'match_not_running'
  | 'insufficient_resources'
  | 'unknown_unit'
  | 'not_owner'
