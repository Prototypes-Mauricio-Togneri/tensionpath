/* eslint-disable @typescript-eslint/no-explicit-any */
import * as path from 'path'
import {argv} from 'process'
import {v4} from 'uuid'
import {createServer} from 'https'
import {IncomingMessage, ServerResponse} from 'http'
import {parse} from 'url'
import {readFileSync} from 'fs'
import {WebSocket, WebSocketServer} from 'ws'

export const baseDir = path.resolve()

// const API_KEY = argv[2]
const PORT = argv[3]
const FULLCHAIN = argv[4]
const PRIVKEY = argv[5]

const handleRequest = (request: IncomingMessage, response: ServerResponse) => {
  const {method, url, headers}  = request
  const parsedUrl = parse(url ?? '', true)
  const {pathname, query} = parsedUrl

  console.log(headers)

  switch (pathname) {
    case '/rooms':
      if (method === 'POST') {
        if (typeof query.startDate === 'string') {
          response.statusCode = 200
          response.setHeader('Content-Type', 'application/json')
          response.write(JSON.stringify({}))
          response.end()
        } else {
          response.statusCode = 400
          response.end()
        }
      } else {
        response.statusCode = 404
        response.end()
      }
      break

    default:
      response.writeHead(404)
      response.end()
  }
}

const server = createServer({
  cert: readFileSync(`${baseDir}/${FULLCHAIN}`),
  key: readFileSync(`${baseDir}/${PRIVKEY}`),
})

server.on('request', handleRequest)

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