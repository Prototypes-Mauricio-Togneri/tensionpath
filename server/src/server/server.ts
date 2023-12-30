/* eslint-disable @typescript-eslint/no-explicit-any */
import * as path from 'path'
import {createServer} from 'https'
import {IncomingMessage, ServerResponse} from 'http'
import {readFileSync} from 'fs'
import {AddressInfo, WebSocket, WebSocketServer} from 'ws'
import {environment} from '../app'
import {RoomsManager} from '../rooms/rooms-manager'
import {Handler} from './handler'
import {Socket} from './socket'
import {Logger} from '../utils/logger'
import {CreateRoom} from '../json/create_room'

const X_API_KEY_HEADER = 'x-api-key'

export class Server {
  constructor(
    readonly roomsManager: RoomsManager,
    readonly handler: Handler,
  ) {}

  private handleRequest(request: IncomingMessage, response: ServerResponse) {
    try {
      const {method, url}  = request

      switch (url) {
        case '/rooms':
          if (method === 'POST') {
            this.handleRoomCreation(request, response)
          }
          break
    
        default:
          response.writeHead(404)
          response.end()
      }
    } catch (e) {
      Logger.error(e)

      response.writeHead(500)
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
  
        try {
          if (apiKey == environment.apiKey) {
            const json = JSON.parse(body) as CreateRoom
            this.roomsManager.create(json)
  
            response.statusCode = 201
          } else {
            response.statusCode = 401
          }
        } catch (e) {
          Logger.error(e)
  
          response.statusCode = 500
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
    
    server.on('request', (request: IncomingMessage, response: ServerResponse) => {
      this.handleRequest(request, response)
    })
    
    const wss = new WebSocketServer({
      server: server,
    })
    
    wss.on('connection', (webSocket: WebSocket, request: IncomingMessage) => {
      const id = request.headers['sec-websocket-key'] as string
      const socket = new Socket(id, webSocket)
      this.handler.onConnect(socket)
    
      webSocket.on('error', (data: unknown) => {
        this.handler.onError(socket, data)
      })
    
      webSocket.on('message', (data: any) => {
        this.handler.onMessage(socket, JSON.parse(data.toString()))
      })
    
      webSocket.on('close', () => {
        this.handler.onDisconnect(socket)
      })
    })
    
    server.listen(environment.port, () => {
      const info = server.address() as AddressInfo
      console.log(`Server running on port ${info.port}`)
    })
  }
}
