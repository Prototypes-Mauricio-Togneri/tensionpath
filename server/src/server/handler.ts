import {JsonMessage} from '../json/server_client/json_message'
import {JsonJoinRoom} from '../json/client_server/json_join_room'
import {RoomsManager} from '../rooms/rooms-manager'
import {Logger} from '../utils/logger'
import {Socket} from './socket'
import {JsonLaunchUnit} from '../json/client_server/json_launch_unit'

export class Handler {
  constructor(
    readonly roomsManager: RoomsManager,
  ) {}

  public onMessage(socket: Socket, data: string) {
    try {
      Logger.log(`<<< ${data}`, socket)
      const json = JSON.parse(data)

      if (json.join) {
        this.roomsManager.join(json.join as JsonJoinRoom, socket)
      } else if (json.launchUnit) {
        this.roomsManager.launchUnit(json.launchUnit as JsonLaunchUnit, socket)
      } else {
        socket.send(JsonMessage.error(`Unknown incoming message ${data}`))
      }
    } catch (e) {
      if (e instanceof JsonMessage) {
        socket.send(e)
      } else {
        socket.send(JsonMessage.error(`Unknown error ${e}`))
      }
    }
  }

  public onConnect(socket: Socket) {
    try {
      Logger.log('Connected', socket)
      socket.send(JsonMessage.welcome())
    } catch (e) {
      Logger.error(e, socket)
    }
  }

  public onDisconnect(socket: Socket) {
    try {
      Logger.log('Disconnected', socket)
      this.roomsManager.leave(socket)
    } catch (e) {
      Logger.error(e, socket)
    }
  }

  public onError(socket: Socket, error: unknown) {
    try {
      Logger.error(error, socket)
    } catch (e) {
      Logger.error(e, socket)
    }
  }
}
