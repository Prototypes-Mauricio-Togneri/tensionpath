import {WebSocket} from 'ws'
import {Logger} from '../utils/logger'

export class Socket {
  constructor(
    readonly id: string,
    readonly socket: WebSocket,
  ) {}

  public send(data: string) {
    this.socket.send(data)
    Logger.log(`>>> ${data}`)
  }
}