import {JsonCreateRoom} from '../json/client_server/json_create_room'
import {JsonJoinRoom} from '../json/client_server/json_join_room'
import {JsonCreateUnit} from '../json/client_server/json_create_unit'
import {JsonMessage} from '../json/server_client/json_message'
import {Socket} from '../server/socket'
import {Room} from './room'
import {JsonDestroyUnit} from '../json/client_server/json_destroy_unit'

export class RoomsManager {
  private roomIdToRoom: Record<string, Room> = {}
  private socketToRoom: Record<string, Room> = {}

  public create(json: JsonCreateRoom) {
    const room = Room.fromJson(json)
    this.roomIdToRoom[room.id] = room
  }

  public join(json: JsonJoinRoom, socket: Socket) {
    const room = this.getRoom(json.roomId)
    room.join(json.playerId, socket)
    this.socketToRoom[socket.id] = room
  }

  public leave(socket: Socket) {
    const room = this.socketToRoom[socket.id]

    if (room) {
      room.leave(socket)
      delete this.socketToRoom[socket.id]

      if (room.isEmpty) {
        delete this.roomIdToRoom[room.id]
      }
    } else {
      throw JsonMessage.error('Connection not linked with any room')
    }
  }

  public createUnit(json: JsonCreateUnit, socket: Socket) {
    const room = this.getRoom(json.roomId)
    room.createUnit(socket)
  }

  public destroyUnit(json: JsonDestroyUnit, socket: Socket) {
    const room = this.getRoom(json.roomId)
    room.destroyUnit(socket)
  }

  private getRoom(roomId: string): Room {
    if (this.roomIdToRoom[roomId]) {
      return this.roomIdToRoom[roomId]
    } else {
      throw JsonMessage.error(`Room with ID ${roomId} does not exist`)
    }
  }

  public update(dt: number) {
    for (const room of Object.values(this.roomIdToRoom)) {
      room.update(dt)
    }
  }
}