import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/json_match.dart';
import 'package:tensionpath/domain/json/models/json_player.dart';
import 'package:tensionpath/domain/matches/match_engine.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';

class Match {
  final String id;
  final DateTime createdAt;
  final int numberOfPlayers;
  final String matchType;
  final Map<String, String> players;
  final Map<String, WebSocket> playerIdToWebSocket = {};
  final Map<WebSocket, String> webSocketToPlayerId = {};
  MatchEngine? _engine;

  Match._({
    required this.id,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.players,
  });

  factory Match.fromJson(JsonCreateMatch json) => Match._(
    id: json.matchId,
    createdAt: json.createdAt,
    numberOfPlayers: json.numberOfPlayers,
    matchType: json.matchType,
    players: json.players,
  );

  MatchEngine get engine {
    if (_engine != null) {
      return _engine!;
    } else {
      throw JsonMessage.error('Match not started');
    }
  }

  bool get isEmpty =>
      (_engine != null) &&
      playerIdToWebSocket.isEmpty &&
      webSocketToPlayerId.isEmpty;

  void join({
    required String playerId,
    required WebSocket socket,
  }) {
    if ((_engine == null) && players.containsKey(playerId)) {
      playerIdToWebSocket[playerId] = socket;
      webSocketToPlayerId[socket] = playerId;

      Logger.log(socket, 'Player $playerId joined match $id');

      if (playerIdToWebSocket.length == numberOfPlayers) {
        Logger.info('Match $id started');
        _onMatchStart(MatchEngine.create(this));
      }
    } else {
      throw JsonMessage.error('Player $playerId cannot join match $id');
    }
  }

  void leave(WebSocket socket) {
    if (webSocketToPlayerId.containsKey(socket)) {
      final String playerId = webSocketToPlayerId[socket]!;
      playerIdToWebSocket.remove(playerId);
      webSocketToPlayerId.remove(socket);

      Logger.log(socket, 'Player $playerId left match $id');
    } else {
      throw JsonMessage.error('Cannot find player for socket ${socket.id}');
    }
  }

  Future _onMatchStart(MatchEngine engine) async {
    _engine = engine;

    final List<String> playerIds = players.keys.toList();

    final JsonMatch jsonMatch = await JsonMatch.fromFile('assets/w9h7.json');
    jsonMatch.createdAt = DateTime.now().toUtc().toIso8601String();

    if (jsonMatch.players.length == playerIds.length) {
      for (int i = 0; i < playerIds.length; i++) {
        jsonMatch.players[i].id = playerIds[i];
        jsonMatch.players[i].name = players[playerIds[i]]!;
      }
    } else {
      throw JsonMessage.error(
        'Match players length ${jsonMatch.players.length} does not match expected length ${playerIds.length}',
      );
    }

    for (final MapEntry<String, String> entry in players.entries) {
      final String playerId = entry.key;

      for (final JsonPlayer player in jsonMatch.players) {
        player.isSelf = (player.id == playerId);
      }

      direct(
        playerId: playerId,
        json: JsonMessage.start(jsonMatch),
      );
    }
  }

  void launchUnits({
    required WebSocket socket,
    required int laneId,
    required int amount,
  }) {
    final String playerId = _getPlayerId(socket);
    engine.launchUnits(
      playerId: playerId,
      laneId: laneId,
      amount: amount,
    );
  }

  String _getPlayerId(WebSocket socket) {
    final String? playerId = webSocketToPlayerId[socket];

    if (playerId != null) {
      return playerId;
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

  void update(double dt) {
    if (_engine != null) {
      engine.update(dt);
    }
  }
}
