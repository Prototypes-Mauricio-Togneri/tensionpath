<script setup lang="ts">
/**
 * How long the match has been running.
 * Counts up, because nothing ends a match on time: it is a reference for the
 * economy, which steps every thirty seconds, rather than a deadline.
 */
import {computed} from 'vue'

const SECONDS_PER_MINUTE = 60

/** Digits each half of the clock is padded to */
const CLOCK_DIGITS = 2

const props = defineProps<{
  elapsedSeconds: number
}>()

/**
 * Pads one half of the clock.
 * @param value - Minutes or seconds
 * @returns The value as a fixed-width string
 */
function pad(value: number): string {
  return value.toString().padStart(CLOCK_DIGITS, '0')
}

const clock = computed(() => {
  const total = Math.max(Math.floor(props.elapsedSeconds), 0)

  return `${pad(Math.floor(total / SECONDS_PER_MINUTE))}:${pad(total % SECONDS_PER_MINUTE)}`
})
</script>

<template>
  <div class="match-timer">{{ clock }}</div>
</template>

<style scoped>
/* Neutral ground between the two bases, and the seed the drained parts of
   them grow out of */
.match-timer {
    display: flex;
    align-items: center;
    flex: none;
    padding: 0 1rem;
    align-self: stretch;
    background: var(--color-track);
    color: var(--color-bg);
    font-family: var(--font-numeric);
    font-size: 1.05rem;
    line-height: 1;
    font-variant-numeric: tabular-nums;
}
</style>
