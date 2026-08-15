<script setup lang="ts">
/**
 * The mark on every price in the game.
 * Struck rather than drawn — rim and core, the same ring language the
 * battlefield uses — and sized in em so it always matches the numeral it
 * stands beside, whether that is a cost on a card or the total in hand.
 */
</script>

<template>
  <svg class="coin-icon" viewBox="0 0 16 16">
    <circle class="coin-face" cx="8" cy="8" r="7" />
    <circle class="coin-rim" cx="8" cy="8" r="7" />
    <circle class="coin-core" cx="8" cy="8" r="1.6" />
  </svg>
</template>

<style scoped>
.coin-icon {
    width: 1em;
    height: 1em;
    flex: none;
}

/* Struck blank */
.coin-face {
    fill: rgba(var(--color-accent-rgb), 0.22);
}

/* Milled edge */
.coin-rim {
    fill: none;
    stroke: var(--color-accent);
    stroke-width: 1.4;
}

.coin-core {
    fill: var(--color-accent);
}
</style>
