<script setup lang="ts">
/**
 * The match. Owns the canvas, builds the session that runs behind it, and
 * routes every message to the renderer, the input controller and the HUD.
 * It holds a Transport, never the engine — createLocalSession is the only
 * thing that knows an engine is running in this tab at all.
 */
import {computed, onBeforeUnmount, onMounted, ref, shallowRef, watch} from 'vue'
import PlayerBar from '@/components/match/player_bar.vue'
import ResourceIndicator from '@/components/match/resource_indicator.vue'
import UnitSelector from '@/components/match/unit_selector.vue'
import type {MatchConfig} from '@/domain/entities/match_config'
import type {MatchState} from '@/domain/entities/match_state'
import type {PlayerId} from '@/domain/types/ids'
import type {UnitType} from '@/domain/types/unit_type'
import {DeployController} from '@/input/deploy_controller'
import {MatchRenderer} from '@/renderer/match_renderer'
import {createLocalSession} from '@/session/local_session'
import type {Session} from '@/session/session'

// Seeds the engine's generator; a lobby supplies this once there is one
const RANDOM_SEED_RANGE = 2 ** 31

const canvasElement = ref<HTMLCanvasElement | null>(null)
const matchConfig = shallowRef<MatchConfig | null>(null)
const matchState = shallowRef<MatchState | null>(null)
const localPlayerId = ref<PlayerId | null>(null)
const selectedUnitType = ref<UnitType | null>(null)

let session: Session | null = null
let renderer: MatchRenderer | null = null
let controller: DeployController | null = null

const localPlayer = computed(() => {
  return matchState.value?.players.find((candidate) => candidate.id === localPlayerId.value) ?? null
})

const enemyPlayer = computed(() => {
  return matchState.value?.players.find((candidate) => candidate.id !== localPlayerId.value) ?? null
})

const maxBaseHealth = computed(() => matchConfig.value?.baseHealth ?? 0)

const roster = computed(() => matchConfig.value?.units ?? {})

watch(selectedUnitType, (unitType) => {
  if (controller !== null) {
    controller.selectedUnitType = unitType
  }
})

// Drop a held unit the moment it stops being affordable, so a placement can
// never be sent that the authority is bound to refuse
watch(localPlayer, (player) => {
  const config = matchConfig.value
  const unitType = selectedUnitType.value

  if (player === null || config === null || unitType === null) {
    return
  }

  const stats = config.units[unitType]

  if (stats !== undefined && player.resources < stats.deploymentCost) {
    selectedUnitType.value = null
  }
})

onMounted(() => {
  const canvas = canvasElement.value

  if (canvas === null) {
    return
  }

  const created = createLocalSession(Math.floor(Math.random() * RANDOM_SEED_RANGE))
  const matchRenderer = new MatchRenderer(canvas)
  const deployController = new DeployController({
    canvas: canvas,
    viewport: matchRenderer.viewport,
    transport: created.transport,
    onPreview: (preview) => {
      matchRenderer.deployPreview = preview
    },
  })

  created.transport.onMessage((message) => {
    switch (message.kind) {
      case 'welcome': {
        localPlayerId.value = message.playerId
        matchRenderer.playerId = message.playerId
        break
      }
      case 'start': {
        matchConfig.value = message.config
        matchRenderer.applyStart(message.config, message.battlefield)
        deployController.applyStart(message.config, message.battlefield)
        break
      }
      case 'update': {
        matchState.value = message.state
        matchRenderer.applyUpdate(message.state)
        break
      }
    }
  })

  matchRenderer.start()

  session = created
  renderer = matchRenderer
  controller = deployController
})

onBeforeUnmount(() => {
  controller?.dispose()
  renderer?.dispose()
  session?.dispose()
  controller = null
  renderer = null
  session = null
})
</script>

<template>
  <main class="match-screen">
    <PlayerBar
      v-if="enemyPlayer !== null"
      faction="enemy"
      :name="enemyPlayer.name"
      :base-health="enemyPlayer.baseHealth"
      :max-base-health="maxBaseHealth"
    />
    <div class="match-field">
      <canvas
        ref="canvasElement"
        class="match-canvas"
        :class="{'match-canvas-armed': selectedUnitType !== null}"
      ></canvas>
    </div>
    <PlayerBar
      v-if="localPlayer !== null"
      faction="ally"
      :name="localPlayer.name"
      :base-health="localPlayer.baseHealth"
      :max-base-health="maxBaseHealth"
    >
      <UnitSelector
        :units="roster"
        :resources="localPlayer.resources"
        :selected="selectedUnitType"
        @select="selectedUnitType = $event"
      />
      <ResourceIndicator :amount="localPlayer.resources" />
    </PlayerBar>
  </main>
</template>

<style scoped>
/* Full-height console: rail, field, rail */
.match-screen {
    height: 100vh;
    height: 100dvh;
    display: flex;
    flex-direction: column;
    background: var(--color-bg);
    overflow: hidden;
}

/* The battlefield takes every pixel the rails leave */
.match-field {
    flex: 1;
    min-height: 0;
    position: relative;
}

.match-canvas {
    display: block;
    width: 100%;
    height: 100%;
}

/* A held unit turns the field into a placement surface */
.match-canvas-armed {
    cursor: crosshair;
}
</style>
