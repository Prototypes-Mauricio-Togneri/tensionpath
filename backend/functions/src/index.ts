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

const matchServerUrl = defineString('MATCH_SERVER_URL')
console.log('Match server URL:', matchServerUrl.value())
