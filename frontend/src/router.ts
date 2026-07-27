/**
 * Application routes.
 * History mode — backend/firebase.json rewrites all paths to /index.html.
 */
import {createRouter, createWebHistory} from 'vue-router'
import HomeScreen from '@/components/screens/home_screen.vue'
import MatchScreen from '@/components/screens/match_screen.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeScreen,
    },
    {
      path: '/match',
      name: 'match',
      component: MatchScreen,
    },
  ],
})

export default router
