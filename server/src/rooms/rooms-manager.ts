import {JsonCreateRoom} from '../json/client_server/json_create_room'
import {JsonJoinRoom} from '../json/client_server/json_join_room'
import {JsonMessage} from '../json/server_client/json_message'
import {Socket} from '../server/socket'
import {Room} from './room'

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
    console.log(socket)
    /*if (websocketToRoom.containsKey(socket)) {
      final Room room = websocketToRoom[socket]!
      room.leave(socket)
      websocketToRoom.remove(socket)

      if (room.isEmpty) {
        rooms.remove(room.id, room)
      }
    } else {
      throw JsonMessage.error('Connection not linked with any room')
    }*/
  }

  public increaseMine(json: JSON, socket: Socket) {
    console.log(json)
    console.log(socket)
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.increaseMine(socket)*/
  }

  public increaseAttack(json: JSON, socket: Socket) {
    console.log(json)
    console.log(socket)
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.increaseAttack(socket)*/
  }

  private getRoom(roomId: string): Room {
    if (this.roomIdToRoom[roomId]) {
      return this.roomIdToRoom[roomId]
    } else {
      throw JsonMessage.error('Room with ID $roomId does not exist')
    }
  }

  public update(dt: number) {
    console.log(dt)
    /*for (final Room room in rooms.list) {
      room.update(dt)
    }*/
  }
}