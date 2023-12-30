import {WebSocket} from 'ws'
import {log} from '../utils/logger'

export class Socket {
  constructor(
    readonly id: string,
    readonly socket: WebSocket,
  ) {}

  public send(data: string) {
    this.socket.send(data)
    log(`>>> ${data}`)
  }
}