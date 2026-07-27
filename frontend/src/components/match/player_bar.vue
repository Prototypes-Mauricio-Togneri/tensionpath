<script setup lang="ts">
/**
 * One player's base, drawn as the share of the top bar they still hold.
 * The two bars drain inward toward the timer, so the neutral ground between
 * them widens as the match wears on and the two remaining lengths can be
 * compared directly across the middle. The name sits at the outer end, on
 * colour the player keeps until the last of it is gone.
 */
import {computed} from 'vue'

const props = defineProps<{
  faction: 'ally' | 'enemy'
  name: string
  baseHealth: number
  maxBaseHealth: number
}>()

const healthFraction = computed(() => {
  if (props.maxBaseHealth <= 0) {
    return 0
  }

  return Math.min(Math.max(props.baseHealth / props.maxBaseHealth, 0), 1)
})
</script>

<template>
  <section class="player-bar" :class="`player-bar-${faction}`">
    <div class="player-bar-fill" :style="{'--health-fraction': healthFraction}"></div>
    <span class="player-name">{{ name }}</span>
  </section>
</template>

<style scoped>
/* Depleted ground, uncovered as the base takes damage */
.player-bar {
    position: relative;
    display: flex;
    align-items: center;
    flex: 1;
    min-width: 0;
    background: var(--color-track);
    overflow: hidden;
}

/* Faction identity drives the fill; ally reads left to right, enemy mirrors it */
.player-bar-ally {
    --faction-color: var(--color-ally);
    justify-content: flex-start;
    padding-left: 1.25rem;
}

.player-bar-enemy {
    --faction-color: var(--color-enemy);
    justify-content: flex-end;
    padding-right: 1.25rem;
}

/* Base health remaining, retreating toward the outer edge */
.player-bar-fill {
    position: absolute;
    inset: 0;
    background: var(--faction-color);
    transform: scaleX(var(--health-fraction, 1));
    transform-origin: left;
    transition: transform 0.2s linear;
}

.player-bar-enemy .player-bar-fill {
    transform-origin: right;
}

/* Stamped into the bar rather than laid over it */
.player-name {
    position: relative;
    color: var(--color-bg);
    font-family: var(--font-display);
    font-weight: 700;
    font-size: 0.8rem;
    letter-spacing: 0.16em;
    text-transform: uppercase;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
