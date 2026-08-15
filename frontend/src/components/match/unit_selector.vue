<script setup lang="ts">
/**
 * The roster the player deploys from.
 * The cards are handles, not buttons: a unit reaches the field by being
 * carried there, so pressing one starts a drag and nothing else. Ordered by
 * cost, and a card the player cannot pay for is inert — the client greys out
 * what it can predict, so the authority only ever has to refuse a genuine
 * race.
 */
import {computed} from 'vue'
import CoinIcon from '@/components/match/coin_icon.vue'
import UnitIcon from '@/components/match/unit_icon.vue'
import type {UnitStats} from '@/domain/entities/unit_stats'
import type {UnitType} from '@/domain/types/unit_type'
import {t} from '@/i18n/localized'

type UnitEntry = {
  type: UnitType
  label: string
  cost: number
  affordable: boolean
}

const props = defineProps<{
  units: Record<UnitType, UnitStats>
  resources: number
  dragged: UnitType | null
}>()

const emit = defineEmits<{
  dragStart: [unitType: UnitType, source: HTMLElement, event: PointerEvent]
}>()

const entries = computed(() => {
  const roster: UnitEntry[] = []

  for (const unitType of Object.keys(props.units)) {
    const stats = props.units[unitType]

    if (stats === undefined) {
      continue
    }

    roster.push({
      type: unitType,
      label: t(`unit.${unitType}`),
      cost: stats.deploymentCost,
      affordable: stats.deploymentCost <= props.resources,
    })
  }

  return roster.sort((first, second) => first.cost - second.cost)
})

/**
 * Hands a press on an affordable card to the input layer, which owns the drag
 * from there.
 * @param entry - The card that was pressed
 * @param event - The pointer down on it
 */
function handlePointerDown(entry: UnitEntry, event: PointerEvent): void {
  const source = event.currentTarget

  if (!entry.affordable || !(source instanceof HTMLElement)) {
    return
  }

  emit('dragStart', entry.type, source, event)
}
</script>

<template>
  <div class="unit-selector">
    <div
      v-for="entry in entries"
      :key="entry.type"
      class="unit-card"
      :class="{
        'unit-card-held': entry.type === dragged,
        'unit-card-locked': !entry.affordable,
      }"
      @pointerdown="handlePointerDown(entry, $event)"
    >
      <span class="unit-name">{{ entry.label }}</span>
      <span class="unit-art">
        <UnitIcon :unit-type="entry.type" />
      </span>
      <span class="unit-cost">
        {{ entry.cost }}
        <CoinIcon />
      </span>
    </div>
  </div>
</template>

<style scoped>
/* One column, read top to bottom in cost order: cheapest first, dearest last */
.unit-selector {
    display: flex;
    flex-direction: column;
    flex: 0 1 auto;
    min-height: 0;
    gap: 0.5rem;
}

/* Machined key — square, as tall as the rail is wide. Shrinks off square only
   on a viewport too short to stack six, which beats clipping the readout */
.unit-card {
    display: flex;
    flex-direction: column;
    aspect-ratio: 1;
    flex: 0 1 auto;
    min-height: 0;
    padding: 0.45rem 0.5rem;
    background: var(--color-bg-surface);
    border: 0.0625rem solid var(--color-border);
    border-radius: 0.125rem;
    color: var(--color-text);
    cursor: grab;
    touch-action: none;
    transition: background 0.12s ease, border-color 0.12s ease;
}

.unit-card:hover:not(.unit-card-locked) {
    border-color: rgba(var(--color-text-rgb), 0.28);
}

/* In hand — carried, and waiting to be put down somewhere legal */
.unit-card-held {
    background: rgba(var(--color-accent-rgb), 0.14);
    border-color: rgba(var(--color-accent-rgb), 0.65);
    cursor: grabbing;
}

.unit-card-held .unit-name {
    color: var(--color-accent);
}

/* Unaffordable — inert rather than hidden, so the roster stays learnable */
.unit-card-locked {
    opacity: 0.35;
    cursor: default;
}

.unit-name {
    font-family: var(--font-display);
    font-weight: 600;
    font-size: 0.62rem;
    letter-spacing: 0.1em;
    text-transform: uppercase;
}

/* The silhouette, given every pixel the name and the price leave */
.unit-art {
    display: block;
    flex: 1;
    min-height: 0;
    padding: 0.2rem 0;
}

.unit-cost {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 0.25rem;
    font-family: var(--font-numeric);
    font-size: 0.85rem;
    line-height: 1;
    color: var(--color-accent);
    font-variant-numeric: tabular-nums;
}
</style>
