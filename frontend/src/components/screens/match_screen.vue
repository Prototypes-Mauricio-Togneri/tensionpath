<script setup lang="ts">
/**
 * The match. Owns the canvas, builds the session that runs behind it, and
 * routes every message to the renderer, the input controller and the HUD.
 * It holds a Transport, never the engine — createLocalSession is the only
 * thing that knows an engine is running in this tab at all.
 */
import {computed, onBeforeUnmount, onMounted, ref, shallowRef} from 'vue'
import FpsMeter from '@/components/match/fps_meter.vue'
import MatchTimer from '@/components/match/match_timer.vue'
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
const draggedUnitType = ref<UnitType | null>(null)
const framesPerSecond = ref(0)

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

const elapsedSeconds = computed(() => matchState.value?.elapsedSeconds ?? 0)

const roster = computed(() => matchConfig.value?.units ?? {})

/**
 * Hands a press on a roster card to the input layer.
 * @param unitType - The unit being picked up
 * @param source - The card element, which captures the pointer
 * @param event - The pointer down that started the drag
 */
function beginDrag(unitType: UnitType, source: HTMLElement, event: PointerEvent): void {
  controller?.beginDrag(unitType, source, event)
}

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
    onDragChange: (unitType) => {
      draggedUnitType.value = unitType
    },
  })

  matchRenderer.onFrameRate = (measured) => {
    framesPerSecond.value = measured
  }

  created.transport.onMessage((message) => {
    switch (message.kind) {
      case 'welcome': {
        localPlayerId.value = message.playerId
        matchRenderer.playerId = message.playerId
        deployController.playerId = message.playerId
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
    <aside class="control-rail">
      <template v-if="localPlayer !== null">
        <UnitSelector
          :units="roster"
          :resources="localPlayer.resources"
          :dragged="draggedUnitType"
          @drag-start="beginDrag"
        />
        <ResourceIndicator class="resource-readout" :amount="localPlayer.resources" />
      </template>
    </aside>
    <div class="match-console">
      <header class="match-top-bar">
        <PlayerBar
          v-if="localPlayer !== null"
          faction="ally"
          :name="localPlayer.name"
          :base-health="localPlayer.baseHealth"
          :max-base-health="maxBaseHealth"
        />
        <MatchTimer :elapsed-seconds="elapsedSeconds" />
        <PlayerBar
          v-if="enemyPlayer !== null"
          faction="enemy"
          :name="enemyPlayer.name"
          :base-health="enemyPlayer.baseHealth"
          :max-base-health="maxBaseHealth"
        />
      </header>
      <div class="match-field">
        <canvas ref="canvasElement" class="match-canvas"></canvas>
        <FpsMeter class="match-fps" :frames-per-second="framesPerSecond" />
      </div>
    </div>
  </main>
</template>

<style scoped>
/* Full-height console: roster rail beside the match itself */
.match-screen {
    height: 100vh;
    height: 100dvh;
    display: flex;
    background: var(--color-bg);
    overflow: hidden;
}

/* Everything the player spends from, in one column: the roster at the top,
   what is left to spend on it held at the bottom */
.control-rail {
    flex: none;
    width: 15rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
    padding: 1rem 0.75rem;
    background: var(--color-bg-raised);
    border-right: 0.0625rem solid var(--color-border);
}

/* Held at the foot of the rail, under everything it has to pay for */
.resource-readout {
    margin-top: auto;
}

.match-console {
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
}

/* Both bases and the clock, as one continuous band */
.match-top-bar {
    flex: none;
    display: flex;
    align-items: stretch;
    height: 2.25rem;
}

/* The battlefield takes every pixel the rail and the band leave */
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

.match-fps {
    position: absolute;
    right: 0.9rem;
    bottom: 0.7rem;
}
</style>
