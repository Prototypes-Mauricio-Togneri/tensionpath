<script setup lang="ts">
/**
 * One player's rail: who they are and what their base has left.
 * The hairline dividing the rail from the battlefield is the base health
 * meter, draining from the outer edge inward — readable out of the corner of
 * an eye during a match, and it costs the map no room. The numeric readout
 * stays for precision.
 */
import {computed} from 'vue'
import {t} from '@/i18n/localized'

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
    <div class="player-identity">
      <span class="player-mark"></span>
      <span class="player-name">{{ name }}</span>
    </div>
    <div class="player-controls">
      <slot />
    </div>
    <div class="player-base">
      <span class="player-base-label">{{ t('screen.match.base') }}</span>
      <span class="player-base-value">{{ Math.max(Math.round(baseHealth), 0) }}</span>
    </div>
    <div class="player-rail">
      <div class="player-rail-fill" :style="{'--health-fraction': healthFraction}"></div>
    </div>
  </section>
</template>

<style scoped>
/* Instrument rail — flat console, never a floating card */
.player-bar {
    position: relative;
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 0.6rem 1.5rem;
    background: var(--color-bg-raised);
    flex: none;
}

/* Faction identity drives every accent in the rail */
.player-bar-ally {
    --faction-color: var(--color-ally);
    --faction-rgb: var(--color-ally-rgb);
}

.player-bar-enemy {
    --faction-color: var(--color-enemy);
    --faction-rgb: var(--color-enemy-rgb);
    flex-direction: row-reverse;
}

/* Player identity */
.player-identity {
    display: flex;
    align-items: center;
    gap: 0.6rem;
}

/* Chamfered faction chip */
.player-mark {
    width: 0.5rem;
    height: 0.5rem;
    background: var(--faction-color);
    clip-path: polygon(0 0, 100% 0, 100% 60%, 60% 100%, 0 100%);
}

.player-name {
    font-family: var(--font-display);
    font-weight: 600;
    font-size: 0.8rem;
    letter-spacing: 0.14em;
    text-transform: uppercase;
}

/* Controls sit centred between the two readouts */
.player-controls {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1.5rem;
    min-width: 0;
}

/* Base health readout */
.player-base {
    display: flex;
    align-items: baseline;
    gap: 0.5rem;
}

.player-base-label {
    font-size: 0.6rem;
    letter-spacing: 0.22em;
    text-transform: uppercase;
    color: rgba(var(--color-text-rgb), 0.45);
}

.player-base-value {
    font-family: var(--font-numeric);
    font-size: 1.5rem;
    line-height: 1;
    color: var(--faction-color);
}

/* Base health as the hairline bordering the battlefield */
.player-rail {
    position: absolute;
    left: 0;
    right: 0;
    height: 0.125rem;
    background: rgba(var(--color-text-rgb), 0.07);
}

.player-bar-ally .player-rail {
    top: 0;
}

.player-bar-enemy .player-rail {
    bottom: 0;
}

.player-rail-fill {
    height: 100%;
    background: var(--faction-color);
    box-shadow: 0 0 0.75rem rgba(var(--faction-rgb), 0.6);
    transform: scaleX(var(--health-fraction, 1));
    transform-origin: left;
    transition: transform 0.2s linear;
}

.player-bar-enemy .player-rail-fill {
    transform-origin: right;
}

/* Narrow viewports drop the label and tighten the rail */
@media (max-width: 40rem) {
    .player-bar {
        gap: 0.75rem;
        padding: 0.5rem 0.75rem;
    }

    .player-base-label {
        display: none;
    }
}
</style>
