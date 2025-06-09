import {onRequest} from 'firebase-functions/v2/https'
import * as fs from 'fs'

export const version = onRequest((_, res) => {
  const data = fs.readFileSync('static/frontend/version.json', 'utf8')

  try {
    const json = JSON.parse(data)
    res.status(200).json(json)
  } catch (e) {
    res.status(500)
  }
})
