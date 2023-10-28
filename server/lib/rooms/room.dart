import 'dart:io';
import 'package:tensionbase/extensions/web_socket_extension.dart';
import 'package:tensionbase/json/json_message.dart';
import 'package:tensionbase/utils/logger.dart';

class Room {
  final String id;
  final Map<String, WebSocket> playerIdToWebSocket = {};
  final Map<WebSocket, String> webSocketToPlayerId = {};
  double timeSpent = 0;

  Room(this.id);

  void join({
    required String playerId,
    required WebSocket socket,
  }) {
    playerIdToWebSocket[playerId] = socket;
    webSocketToPlayerId[socket] = playerId;

    Logger.log(socket, 'Player $playerId joined room $id');
  }

  void leave(WebSocket socket) {
    final String? playerId = webSocketToPlayerId[socket];

    if (playerId != null) {
      playerIdToWebSocket.remove(playerId);
      webSocketToPlayerId.remove(socket);

      Logger.log(socket, 'Player $playerId left room $id');
    }
  }

  void update(double dt) {
    timeSpent += dt;

    if (timeSpent.toInt() % 5 == 0) {
      for (final WebSocket socket in playerIdToWebSocket.values) {
        socket.send(JsonMessage(type: timeSpent.toString()));
      }
    }
  }
}
