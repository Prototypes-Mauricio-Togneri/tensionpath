import {WebSocket} from 'ws'

export class Socket {
  constructor(
    readonly id: string,
    readonly socket: WebSocket,
  ) {}
}