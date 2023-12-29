import {Socket} from '../server/socket'
import {Room} from './room'

export class RoomsManager {
  private rooms: Record<string, Room> = {}
  private websocketToRoom: Record<string, Room> = {}

  public create(json: JSON) {
    //final Room room = Room.fromJson(json)
    //rooms.add(json.roomId, room)
  }

  public join(json: JSON, socket: Socket) {
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.join(
      playerId: json.playerId,
      socket: socket,
    )
    websocketToRoom[socket] = room*/
  }

  public leave(socket: Socket) {
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
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.increaseMine(socket)*/
  }

  public increaseAttack(json: JSON, socket: Socket) {
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.increaseAttack(socket)*/
  }

  public launchUnits(json: JSON, socket: Socket) {
    /*final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    )
    room.launchUnits(socket, json.laneId, json.amount)*/
  }

  private getRoom(roomId: string, socket: Socket): Room {
    /*if (rooms.has(roomId)) {
      return rooms.get(roomId)
    } else {
      throw JsonMessage.error('Room with ID $roomId does not exist')
    }*/

    return new Room()
  }

  public update(dt: number) {
    /*for (final Room room in rooms.list) {
      room.update(dt)
    }*/
  }
}