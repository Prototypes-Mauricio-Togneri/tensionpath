<script setup lang="ts">
/**
 * What the player has to spend, in the same coin every card is priced in.
 * Floored rather than rounded, so the number never promises more than can
 * actually be paid.
 */
import CoinIcon from '@/components/match/coin_icon.vue'

defineProps<{
  amount: number
}>()
</script>

<template>
  <div class="resource-indicator">
    <span class="resource-value">{{ Math.floor(amount) }}</span>
    <CoinIcon />
  </div>
</template>

<style scoped>
.resource-indicator {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 0.4rem;
}

.resource-value {
    font-family: var(--font-numeric);
    font-size: 1.5rem;
    line-height: 1;
    color: var(--color-accent);
    font-variant-numeric: tabular-nums;
}
</style>
