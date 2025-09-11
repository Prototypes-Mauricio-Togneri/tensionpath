import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
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

  MatchEngine get match {
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

  void _onMatchStart(MatchEngine match) {
    Logger.info('Match started: $id');
    _engine = match;

    /*for (final Player player in _match!.players) {
      direct(
        playerId: player.id,
        json: JsonMessage.update(_match!.json(player)),
      );
    }*/
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
      throw JsonMessage.error('Player not in match');
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
