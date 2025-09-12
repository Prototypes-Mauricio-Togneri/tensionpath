import {initializeApp} from 'firebase-admin/app'
import {defineString} from 'firebase-functions/params'
import {setGlobalOptions} from 'firebase-functions/v2/options'

initializeApp()

setGlobalOptions({
  region: 'europe-west6',
  timeoutSeconds: 60,
})

export * from './entry-points'

export const MATCH_SERVER_HTTP = defineString('MATCH_SERVER_HTTP').value()
console.log('Match server HTTP:', MATCH_SERVER_HTTP)

export const MATCH_SERVER_WS = defineString('MATCH_SERVER_WS').value()
console.log('Match server WS:', MATCH_SERVER_WS)

export const API_KEY = defineString('API_KEY').value()
console.log('API Key:', API_KEY)

export const IS_EMULATOR = Boolean(process.env.FUNCTIONS_EMULATOR)
