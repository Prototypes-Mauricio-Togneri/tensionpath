import * as fs from 'fs'
import {app} from '..'

export const version = app.get('/version', (_, res) => {
  const data = fs.readFileSync('static/frontend/version.json', 'utf8')

  try {
    const json = JSON.parse(data)
    res.status(200).json(json)
  } catch (_) {
    res.status(500)
  }
})
