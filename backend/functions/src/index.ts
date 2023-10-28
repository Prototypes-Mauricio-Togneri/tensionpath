export * from './entry-points'
import {firestore} from 'firebase-admin'
import {initializeApp} from 'firebase-admin/app'
import {onRequest} from 'firebase-functions/v2/https'
import {setGlobalOptions} from 'firebase-functions/v2/options'

initializeApp()
firestore().settings({ignoreUndefinedProperties: true})

setGlobalOptions({
  region: 'europe-west6',
  timeoutSeconds: 60,
})

export const matchFinished = onRequest((request, response) => {
  console.log(request.body)
  response.send('Hello from Firebase 6')
})
