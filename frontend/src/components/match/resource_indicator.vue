<script setup lang="ts">
/**
 * Tension in hand. Amber, like every other telemetry readout, and floored
 * rather than rounded so the number never promises more than can be spent.
 */
import {t} from '@/i18n/localized'

defineProps<{
  amount: number
}>()
</script>

<template>
  <div class="resource-indicator">
    <span class="resource-glyph"></span>
    <span class="resource-value">{{ Math.floor(amount) }}</span>
    <span class="resource-unit">{{ t('screen.match.resource_unit') }}</span>
  </div>
</template>

<style scoped>
.resource-indicator {
    display: flex;
    align-items: baseline;
    gap: 0.4rem;
}

/* Amber lozenge marking the readout as telemetry */
.resource-glyph {
    align-self: center;
    width: 0.45rem;
    height: 0.45rem;
    background: var(--color-accent);
    transform: rotate(45deg);
}

.resource-value {
    font-family: var(--font-numeric);
    font-size: 1.5rem;
    line-height: 1;
    color: var(--color-accent);
    font-variant-numeric: tabular-nums;
}

.resource-unit {
    font-size: 0.7rem;
    letter-spacing: 0.18em;
    color: rgba(var(--color-accent-rgb), 0.55);
}
</style>
