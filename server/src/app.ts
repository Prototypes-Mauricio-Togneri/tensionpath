/* eslint-disable @typescript-eslint/no-explicit-any */
import {argv} from 'process'
import {v4} from 'uuid'
import {createServer} from 'https'
import {readFileSync} from 'fs'
import {WebSocket, WebSocketServer} from 'ws'

// const API_KEY = argv[2]
const PORT = argv[3]
const FULLCHAIN = argv[4]
const PRIVKEY = argv[5]

const server = createServer({
  cert: readFileSync(FULLCHAIN),
  key: readFileSync(PRIVKEY),
})

const wss = new WebSocketServer({
  server: server,
})

const onMessage = (ws: WebSocket, message: string) => {
  log(`<<< ${message}`)
  ws.send(message)
}

wss.on('connection', (ws: WebSocket) => {
  const id = v4()

  log(`Client connected: ${id}`)

  ws.on('error', (data: any) => {
    log(`Error: ${id}. ${data}`)
  })

  ws.on('message', (data: any) => {
    onMessage(ws, data.toString())
  })

  ws.on('close', () => {
    log(`Client disconnected: ${id}`)
  })

  send(ws, 'welcome')
})

server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`)
})

export const send = (ws: WebSocket, data: string) => {
  ws.send(data)
  log(`>>> ${data}`)
}

export const log = (data: string) => {
  console.log(`${new Date().toISOString()} ${data}`)
}