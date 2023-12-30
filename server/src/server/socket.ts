/* eslint-disable @typescript-eslint/no-explicit-any */
import {WebSocket} from 'ws'
import {Logger} from '../utils/logger'
import {JsonMessage} from '../json/json_message'

export class Socket {
  constructor(
    readonly id: string,
    readonly socket: WebSocket,
  ) {}

  public send(json: JsonMessage) {
    this.socket.send(json.toString())
    Logger.log(`>>> ${json.toString()}`, this)
  }
}