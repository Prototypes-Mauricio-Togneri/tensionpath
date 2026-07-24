import {readFileSync} from 'node:fs'
import {fileURLToPath, URL} from 'node:url'
import vue from '@vitejs/plugin-vue'
import {defineConfig} from 'vite'
import vueDevTools from 'vite-plugin-vue-devtools'

const packageJson = JSON.parse(readFileSync('./package.json', 'utf-8')) as {version: string}

export default defineConfig({
  // vueDevTools is dev-only — it adds nothing to the production bundle
  plugins: [
    vue(),
    vueDevTools(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  define: {
    __APP_VERSION__: JSON.stringify(packageJson.version),
  },
  build: {
    // Firebase Hosting serves backend/public (see backend/firebase.json)
    outDir: '../backend/public',
    emptyOutDir: true,
  },
})
