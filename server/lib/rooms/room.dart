import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_room.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/models/match.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';

class Room {
  final String id;
  final DateTime createdAt;
  final int numberOfPlayers;
  final String matchType;
  final Map<String, String> players;
  final Map<String, WebSocket> playerIdToWebSocket = {};
  final Map<WebSocket, String> webSocketToPlayerId = {};
  Match? _match;

  Room._({
    required this.id,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.players,
  });

  factory Room.fromJson(JsonCreateRoom json) => Room._(
    id: json.roomId,
    createdAt: json.createdAt,
    numberOfPlayers: json.numberOfPlayers,
    matchType: json.matchType,
    players: json.players,
  );

  Match get match {
    if (_match != null) {
      return _match!;
    } else {
      throw JsonMessage.error('Match not started');
    }
  }

  bool get isEmpty =>
      (_match != null) &&
      playerIdToWebSocket.isEmpty &&
      webSocketToPlayerId.isEmpty;

  void join({
    required String playerId,
    required WebSocket socket,
  }) {
    if ((_match == null) && players.containsKey(playerId)) {
      playerIdToWebSocket[playerId] = socket;
      webSocketToPlayerId[socket] = playerId;

      Logger.log(socket, 'Player $playerId joined room $id');

      if (playerIdToWebSocket.length == numberOfPlayers) {
        _match = Match.create(this);

        /*for (final Player player in _match!.players) {
          direct(
            playerId: player.id,
            json: JsonMessage.update(_match!.json(player)),
          );
        }*/
      }
    } else {
      throw JsonMessage.error('Player $playerId cannot join room $id');
    }
  }

  void leave(WebSocket socket) {
    if (webSocketToPlayerId.containsKey(socket)) {
      final String playerId = webSocketToPlayerId[socket]!;
      playerIdToWebSocket.remove(playerId);
      webSocketToPlayerId.remove(socket);

      Logger.log(socket, 'Player $playerId left room $id');
    } else {
      throw JsonMessage.error('Cannot find player for socket ${socket.id}');
    }
  }

  void increaseMine(WebSocket socket) {
    //final String playerId = _getPlayerId(socket);
    //match.increaseMine(playerId);
  }

  void increaseAttack(WebSocket socket) {
    //final String playerId = _getPlayerId(socket);
    //match.increaseAttack(playerId);
  }

  void launchUnits(WebSocket socket, int laneId, int amount) {
    //final String playerId = _getPlayerId(socket);
    //match.launchUnits(playerId, laneId, amount);
  }

  /*String _getPlayerId(WebSocket socket) {
    final String? playerId = webSocketToPlayerId[socket];

    if (playerId != null) {
      return playerId;
    } else {
      throw JsonMessage.error('Player not in room');
    }
  }*/

  void direct({
    required String playerId,
    required JsonMessage json,
  }) {
    final WebSocket socket = playerIdToWebSocket[playerId]!;
    socket.send(json);
  }

  void broadcast(JsonMessage json) {
    for (final WebSocket socket in webSocketToPlayerId.keys) {
      socket.send(json);
    }
  }

  void update(double dt) {
    //_match?.update(dt);
  }
}
