import 'dart:io';
import 'package:tensionpath/domain/engine/match.dart';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';

class Connection {
  final String matchId;
  final DateTime createdAt;
  final int numberOfPlayers;
  final String matchType;
  final Map<String, String> players;
  final Map<String, String> playerIdToIndex = {};
  final Map<String, WebSocket> playerIdToWebSocket = {};
  final Map<WebSocket, String> webSocketToPlayerId = {};
  Match? _match;

  Connection._({
    required this.matchId,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.players,
  });

  factory Connection.fromJson(JsonCreateMatch json) => Connection._(
    matchId: json.matchId,
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

      Logger.log(socket, 'Player $playerId joined match $matchId');

      if (playerIdToWebSocket.length == numberOfPlayers) {
        Logger.info('Match $matchId started');
        _onMatchStart();
      }
    } else {
      throw JsonMessage.error('Player $playerId cannot join match $matchId');
    }
  }

  void leave(WebSocket socket) {
    if (webSocketToPlayerId.containsKey(socket)) {
      final String playerId = webSocketToPlayerId[socket]!;
      playerIdToWebSocket.remove(playerId);
      webSocketToPlayerId.remove(socket);

      Logger.log(socket, 'Player $playerId left match $matchId');
    } else {
      throw JsonMessage.error('Cannot find player for socket ${socket.id}');
    }
  }

  Future _onMatchStart() async {
    final JsonMatch jsonMatch = await JsonMatch.fromFile('assets/w9h7.json');
    jsonMatch.createdAt = DateTime.now().toUtc().toIso8601String();

    final List<MapEntry<String, String>> playersData = players.entries.toList();

    if (jsonMatch.players.length == playersData.length) {
      for (int i = 0; i < playersData.length; i++) {
        final JsonPlayer jsonPlayer = jsonMatch.players[i];
        jsonPlayer.id = playersData[i].key;
        jsonPlayer.name = playersData[i].value;
        playerIdToIndex[jsonPlayer.id] = jsonPlayer.index;
      }
    } else {
      throw JsonMessage.error(
        'Match players length ${jsonMatch.players.length} does not match expected length ${playersData.length}',
      );
    }

    _match = Match.fromJson(
      connection: this,
      jsonMatch: jsonMatch,
    );

    for (final String playerId in players.keys) {
      for (final JsonPlayer player in jsonMatch.players) {
        player.isSelf = (player.id == playerId);
      }

      direct(
        playerId: playerId,
        json: JsonMessage.start(jsonMatch),
      );
    }
  }

  void deployUnit({
    required WebSocket socket,
    required JsonLocation location,
    required UnitType type,
  }) {
    match.deployUnit(
      playerIndex: _getPlayerIndex(socket),
      location: location,
      type: type,
    );
  }

  String _getPlayerIndex(WebSocket socket) {
    final String? playerId = webSocketToPlayerId[socket];

    if (playerId != null) {
      return playerIdToIndex[playerId]!;
    } else {
      throw JsonMessage.error('Player not in match');
    }
  }

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

  void update(double dt) => _match?.update(dt);
}
