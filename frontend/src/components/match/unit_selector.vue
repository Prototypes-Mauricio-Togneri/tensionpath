<script setup lang="ts">
/**
 * The roster the player deploys from.
 * Cards are machined keys rather than buttons, ordered by cost. A card the
 * player cannot pay for is inert — the client greys out what it can predict,
 * so the authority only ever has to refuse a genuine race.
 */
import {computed} from 'vue'
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
  selected: UnitType | null
}>()

const emit = defineEmits<{
  select: [unitType: UnitType | null]
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
 * Selects a unit, or clears the selection when it is already held.
 * @param unitType - The card that was pressed
 */
function toggle(unitType: UnitType): void {
  emit('select', props.selected === unitType ? null : unitType)
}
</script>

<template>
  <div class="unit-selector">
    <button
      v-for="entry in entries"
      :key="entry.type"
      type="button"
      class="unit-card"
      :class="{
        'unit-card-selected': entry.type === selected,
        'unit-card-locked': !entry.affordable,
      }"
      :disabled="!entry.affordable"
      @click="toggle(entry.type)"
    >
      <span class="unit-name">{{ entry.label }}</span>
      <span class="unit-cost">{{ entry.cost }}</span>
    </button>
  </div>
</template>

<style scoped>
.unit-selector {
    display: flex;
    align-items: stretch;
    gap: 0.5rem;
}

/* Machined key — chamfered top-right corner, no rounded chip */
.unit-card {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 0.2rem;
    min-width: 5.25rem;
    padding: 0.4rem 0.7rem 0.35rem;
    background: var(--color-bg-surface);
    border: 0.0625rem solid var(--color-border);
    border-radius: 0.125rem;
    clip-path: polygon(0 0, calc(100% - 0.5rem) 0, 100% 0.5rem, 100% 100%, 0 100%);
    color: var(--color-text);
    font-family: var(--font-display);
    cursor: pointer;
    transition: background 0.12s ease, border-color 0.12s ease;
}

.unit-card:hover:not(.unit-card-locked) {
    border-color: rgba(var(--color-text-rgb), 0.28);
}

/* Held unit — armed and waiting for a placement */
.unit-card-selected {
    background: rgba(var(--color-accent-rgb), 0.14);
    border-color: rgba(var(--color-accent-rgb), 0.65);
}

.unit-card-selected .unit-name {
    color: var(--color-accent);
}

/* Unaffordable — inert rather than hidden, so the roster stays learnable */
.unit-card-locked {
    opacity: 0.35;
    cursor: not-allowed;
}

.unit-name {
    font-size: 0.7rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
}

.unit-cost {
    font-family: var(--font-numeric);
    font-size: 0.95rem;
    line-height: 1;
    color: var(--color-accent);
}

/* Narrow viewports drop the cards to icons' width */
@media (max-width: 40rem) {
    .unit-card {
        min-width: 4rem;
        padding: 0.35rem 0.5rem 0.3rem;
    }
}
</style>
