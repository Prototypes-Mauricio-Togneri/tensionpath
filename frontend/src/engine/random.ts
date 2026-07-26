import type {MatchState} from '@/domain/entities/match_state'

/**
 * Deterministic pseudo-random source (mulberry32).
 * The seed lives in MatchState rather than in a module, so a match replays
 * identically from its seed plus the recorded command log. Math.random is
 * banned inside src/engine/ for exactly this reason — see eslint.config.js.
 * @param state - The state whose seed is advanced in place
 * @returns A value in [0, 1)
 */
export function nextRandom(state: MatchState): number {
  state.randomSeed = (state.randomSeed + 0x6D2B79F5) | 0

  let value = state.randomSeed
  value = Math.imul(value ^ (value >>> 15), value | 1)
  value ^= value + Math.imul(value ^ (value >>> 7), value | 61)

  return ((value ^ (value >>> 14)) >>> 0) / 4294967296
}
