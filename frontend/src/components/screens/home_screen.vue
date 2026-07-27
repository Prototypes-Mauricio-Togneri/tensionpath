<script setup lang="ts">
/**
 * Landing screen. A title and the way into a match, until there is a lobby.
 */
import {t} from '@/i18n/localized'
</script>

<template>
  <main class="screen-layout">
    <h1 class="home-title">{{ t('app.title') }}</h1>
    <RouterLink class="home-play" to="/match">{{ t('screen.home.play') }}</RouterLink>
  </main>
</template>

<style scoped>
.home-title {
    font-family: var(--font-display);
    font-weight: 700;
    font-size: 2.5rem;
    letter-spacing: 0.24em;
    text-transform: uppercase;
    margin-bottom: 2rem;
}

/* Chamfered key, matching the roster cards in a match */
.home-play {
    padding: 0.7rem 2rem;
    background: var(--color-bg-surface);
    border: 0.0625rem solid rgba(var(--color-accent-rgb), 0.5);
    border-radius: 0.125rem;
    clip-path: polygon(0 0, calc(100% - 0.6rem) 0, 100% 0.6rem, 100% 100%, 0 100%);
    color: var(--color-accent);
    font-family: var(--font-display);
    font-weight: 600;
    font-size: 0.85rem;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    text-decoration: none;
    transition: background 0.12s ease;
}

.home-play:hover {
    background: rgba(var(--color-accent-rgb), 0.14);
}
</style>
