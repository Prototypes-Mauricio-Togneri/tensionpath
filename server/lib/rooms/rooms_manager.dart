import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_room.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_attack.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_increase_mine.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_room.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/rooms/room.dart';
import 'package:tensionpath/utils/map_list.dart';

class RoomsManager {
  final MapList<String, Room> rooms = MapList();
  final Map<WebSocket, Room> websocketToRoom = {};

  void create(JsonCreateRoom json) {
    final Room room = Room.fromJson(json);
    rooms.add(json.roomId, room);
  }

  void join({
    required JsonJoinRoom json,
    required WebSocket socket,
  }) {
    final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    );
    room.join(
      playerId: json.playerId,
      socket: socket,
    );
    websocketToRoom[socket] = room;
  }

  void leave(WebSocket socket) {
    if (websocketToRoom.containsKey(socket)) {
      final Room room = websocketToRoom[socket]!;
      room.leave(socket);
      websocketToRoom.remove(socket);

      if (room.isEmpty) {
        rooms.remove(room.id, room);
      }
    } else {
      throw JsonMessage.error('Connection not linked with any room');
    }
  }

  void increaseMine({
    required JsonIncreaseMine json,
    required WebSocket socket,
  }) {
    final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    );
    room.increaseMine(socket);
  }

  void increaseAttack({
    required JsonIncreaseAttack json,
    required WebSocket socket,
  }) {
    final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    );
    room.increaseAttack(socket);
  }

  void launchUnits({
    required JsonLaunchUnits json,
    required WebSocket socket,
  }) {
    final Room room = _getRoom(
      roomId: json.roomId,
      socket: socket,
    );
    room.launchUnits(socket, json.laneId, json.amount);
  }

  Room _getRoom({
    required String roomId,
    required WebSocket socket,
  }) {
    if (rooms.has(roomId)) {
      return rooms.get(roomId);
    } else {
      throw JsonMessage.error('Room with ID $roomId does not exist');
    }
  }

  void update(double dt) {
    for (final Room room in rooms.list) {
      room.update(dt);
    }
  }
}
