import {initializeApp} from 'firebase-admin/app'
import {setGlobalOptions} from 'firebase-functions/v2/options'

export const isEmulator = Boolean(process.env.FUNCTIONS_EMULATOR)

initializeApp()

setGlobalOptions({
  region: 'europe-west6',
  timeoutSeconds: 60,
})

export * from './entry-points'
