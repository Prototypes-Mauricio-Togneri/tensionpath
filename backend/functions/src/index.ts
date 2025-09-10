import {initializeApp} from 'firebase-admin/app'
import {defineString} from 'firebase-functions/params'
import {setGlobalOptions} from 'firebase-functions/v2/options'

export const isEmulator = Boolean(process.env.FUNCTIONS_EMULATOR)

initializeApp()

setGlobalOptions({
  region: 'europe-west6',
  timeoutSeconds: 60,
})

export * from './entry-points'

export const MATCH_SERVER = defineString('MATCH_SERVER').value()
console.log('Match server:', MATCH_SERVER)
