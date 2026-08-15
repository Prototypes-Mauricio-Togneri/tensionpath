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
/* Black seam between the two bases, holding the clock clear of either
   faction's colour and of the ground they drain into.
   The width is fixed rather than fitted to the digits: Electrolize has no
   tabular figures to hold them to one advance, so a seam sized by content
   would shove both bases sideways on every tick */
.match-timer {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: none;
    width: 5rem;
    align-self: stretch;
    background: var(--color-bg-deep);
    color: var(--color-text-strong);
    font-family: var(--font-numeric);
    font-size: 1.05rem;
    line-height: 1;
    font-variant-numeric: tabular-nums;
}
</style>
