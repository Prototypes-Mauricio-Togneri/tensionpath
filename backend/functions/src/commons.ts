import {setGlobalOptions} from 'firebase-functions/v2'

export const COLLECTIONS = {
  PLAYERS: 'players',
  ROOMS: 'rooms',
}

setGlobalOptions({
  // region: LOCATION,
  timeoutSeconds: 540,
  // enforceAppCheck: true,
})
