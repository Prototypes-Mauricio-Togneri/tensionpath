<script setup lang="ts">
/**
 * Frames actually reaching the screen, averaged by the renderer.
 * Instrumentation rather than HUD: it sits in the corner of the field at the
 * dimmest legible weight, and never intercepts a pointer on its way to a
 * deployment.
 */
import {t} from '@/i18n/localized'

defineProps<{
  framesPerSecond: number
}>()
</script>

<template>
  <div class="fps-meter">
    <span class="fps-value">{{ framesPerSecond }}</span>
    <span class="fps-label">{{ t('screen.match.fps') }}</span>
  </div>
</template>

<style scoped>
.fps-meter {
    display: flex;
    align-items: baseline;
    gap: 0.3rem;
    pointer-events: none;
}

.fps-value {
    font-family: var(--font-numeric);
    font-size: 0.85rem;
    line-height: 1;
    color: rgba(var(--color-text-rgb), 0.4);
    font-variant-numeric: tabular-nums;
}

.fps-label {
    font-size: 0.6rem;
    letter-spacing: 0.18em;
    color: rgba(var(--color-text-rgb), 0.25);
}
</style>
