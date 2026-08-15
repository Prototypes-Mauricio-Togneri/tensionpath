<script setup lang="ts">
/**
 * A unit's silhouette on its roster card.
 * Drawn from the same vocabulary the battlefield draws from, in the player's
 * own colour and facing the way their units travel — so the card is a preview
 * of the thing that will be in the lane, not an illustration of it.
 */
import {computed} from 'vue'
import type {UnitType} from '@/domain/types/unit_type'
import {shapeFor} from '@/renderer/unit_shapes'

/**
 * Half-extent of the drawing box, in the same units the shapes are defined in.
 * Clear of the furthest vertex any silhouette reaches, plus the stroke that
 * sits astride it — a box sized to the vertex alone shaves the ranger's nose.
 */
const VIEW_REACH = 1.45

const props = defineProps<{
  unitType: UnitType
}>()

const points = computed(() => {
  return shapeFor(props.unitType).map((point) => `${point.x},${point.y}`).join(' ')
})
</script>

<template>
  <svg class="unit-icon" :viewBox="`${-VIEW_REACH} ${-VIEW_REACH} ${VIEW_REACH * 2} ${VIEW_REACH * 2}`">
    <polygon class="unit-icon-shape" :points="points" />
  </svg>
</template>

<style scoped>
.unit-icon {
    display: block;
    width: 100%;
    height: 100%;
}

/* Same fill-and-outline treatment the canvas gives the unit itself */
.unit-icon-shape {
    fill: rgba(var(--color-ally-rgb), 0.35);
    stroke: var(--color-ally);
    stroke-width: 0.11;
    stroke-linejoin: round;
}
</style>
