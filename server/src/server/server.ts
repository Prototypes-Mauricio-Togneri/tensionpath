/* eslint-disable @typescript-eslint/no-explicit-any */
import * as path from 'path'
import {createServer} from 'https'
import {IncomingMessage, ServerResponse} from 'http'
import {parse} from 'url'
import {readFileSync} from 'fs'
import {WebSocket, WebSocketServer} from 'ws'
import {environment} from '../app'
import {RoomsManager} from '../rooms/rooms-manager'
import {Handler} from './handler'

const X_API_KEY_HEADER = 'x-api-key'

export class Server {
  constructor(
    readonly roomsManager: RoomsManager,
    readonly handler: Handler,
  ) {}

  private handleRequest(request: IncomingMessage, response: ServerResponse) {
    const {method, url}  = request
    const parsedUrl = parse(url ?? '', true)
    const {pathname} = parsedUrl
  
    switch (pathname) {
      case '/rooms':
        if (method === 'POST') {
          this.handleRoomCreation(request, response)
        }
        break
  
      default:
        response.writeHead(404)
        response.end()
    }
  }

  private handleRoomCreation(request: IncomingMessage, response: ServerResponse) {
    const apiKey = request.headers[X_API_KEY_HEADER]

    let body: any = []
    request
      .on('data', chunk => {
        body.push(chunk)
      })
      .on('end', () => {
        body = Buffer.concat(body).toString()

        if (apiKey == environment.apiKey) {
          const json = JSON.parse(body)
          this.roomsManager.create(json)

          response.statusCode = 201
          response.setHeader('Content-Type', 'application/json')
        } else {
          response.statusCode = 401
        }

        response.end()
      })
  }

  public start() {
    const baseDir = path.resolve()

    const server = createServer({
      cert: readFileSync(`${baseDir}/${environment.fullchain}`),
      key: readFileSync(`${baseDir}/${environment.privkey}`),
    })
    
    server.on('request', this.handleRequest)
    
    const wss = new WebSocketServer({
      server: server,
    })
    
    wss.on('connection', (ws: WebSocket) => {
      this.handler.onConnect(ws)
    
      ws.on('error', (data: unknown) => {
        this.handler.onError(ws, data)
      })
    
      ws.on('message', (data: any) => {
        this.handler.onMessage(ws, JSON.parse(data.toString()))
      })
    
      ws.on('close', () => {
        this.handler.onDisconnect(ws)
      })
    })
    
    server.listen(environment.port, () => {
      console.log(`Server running on port ${environment.port}`)
    })
  }
}

/*export const send = (ws: WebSocket, data: string) => {
  ws.send(data)
  log(`>>> ${data}`)
}*/
