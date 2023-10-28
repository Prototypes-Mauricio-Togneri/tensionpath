import 'dart:io';
import 'package:tensionpath/json/json_create_room.dart';
import 'package:tensionpath/json/json_join_room.dart';
import 'package:tensionpath/rooms/room.dart';
import 'package:tensionpath/utils/map_list.dart';

class RoomsManager {
  final MapList<String, Room> rooms = MapList();

  void create(JsonCreateRoom json) {
    rooms.add(json.roomId, Room(json.roomId));
  }

  bool join({
    required JsonJoinRoom json,
    required WebSocket socket,
  }) {
    if (rooms.has(json.roomId)) {
      final Room room = rooms.get(json.roomId);
      room.join(
        playerId: json.playerId,
        socket: socket,
      );

      return true;
    } else {
      return false;
    }
  }

  void leave(WebSocket socket) {
    for (final Room room in rooms.list) {
      room.leave(socket);
    }
  }

  void update(double dt) {
    for (final Room room in rooms.list) {
      room.update(dt);
    }
  }
}
