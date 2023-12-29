/* eslint-disable @typescript-eslint/no-explicit-any */
import * as path from 'path';
import {argv} from 'process'
import {v4} from 'uuid'
import {createServer} from 'https'
import {IncomingMessage, ServerResponse} from 'http';
import url from 'url';
import {readFileSync} from 'fs'
import {WebSocket, WebSocketServer} from 'ws'

export const baseDir = path.resolve()

// const API_KEY = argv[2]
const PORT = argv[3]
const FULLCHAIN = argv[4]
const PRIVKEY = argv[5]

const handleRequest = async (request: IncomingMessage, response: ServerResponse) => {
  const parsedUrl = url.parse(request.url ?? '', true);
  const {method, headers}  = request;
  const {pathname, query} = parsedUrl;

  console.log(headers)

  switch (pathname) {
    case '/rooms':
      if (method === 'POST') {
        if (typeof query.startDate === 'string' && typeof query.endDate === 'string') {
          response.writeHead(200, { 'Content-Type': 'application/json' });
          response.end(JSON.stringify({}));
        } else {
          response.writeHead(400, { 'Content-Type': 'application/json' });
          response.end('Missing startDate or enDate');
        }
      } else {
        response.writeHead(404);
        response.end();
      }

      return;
    default:
      response.writeHead(404);
      response.end();
  }
}

const server = createServer({
  cert: readFileSync(`${baseDir}/${FULLCHAIN}`),
  key: readFileSync(`${baseDir}/${PRIVKEY}`),
})

server.on('request', handleRequest);

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