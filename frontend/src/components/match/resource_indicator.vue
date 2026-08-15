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
/* A readout, not a key: same machined surface as the roster cards, but held
   in amber throughout so it is never mistaken for one. The font size is here
   to strike the coin — it carries no text of its own */
.resource-indicator {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    padding: 0.7rem 0.6rem;
    background: var(--color-bg-surface);
    border: 0.0625rem solid rgba(var(--color-accent-rgb), 0.4);
    border-radius: 0.125rem;
    font-size: 1.6rem;
}

.resource-value {
    font-family: var(--font-numeric);
    font-size: 2.1rem;
    line-height: 1;
    color: var(--color-accent);
    font-variant-numeric: tabular-nums;
}
</style>
