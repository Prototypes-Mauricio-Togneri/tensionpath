import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_deploy_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/matches/match.dart';
import 'package:tensionpath/utils/map_list.dart';

class MatchManager {
  final MapList<String, Match> matches = MapList();
  final Map<WebSocket, Match> websocketToMatch = {};

  bool hasMatch(String matchId) => matches.has(matchId);

  void create(JsonCreateMatch json) {
    final Match match = Match.fromJson(json);
    matches.add(json.matchId, match);
  }

  void join({
    required JsonJoinMatch json,
    required WebSocket socket,
  }) {
    final Match match = _getMatch(json.matchId);
    match.join(
      playerId: json.playerId,
      socket: socket,
    );
    websocketToMatch[socket] = match;
  }

  void leave(WebSocket socket) {
    if (websocketToMatch.containsKey(socket)) {
      final Match match = websocketToMatch[socket]!;
      match.leave(socket);
      websocketToMatch.remove(socket);

      if (match.isEmpty) {
        matches.remove(match.id, match);
      }
    } else {
      throw JsonMessage.error('Connection not linked with any match');
    }
  }

  void deployUnit({
    required JsonDeployUnit json,
    required WebSocket socket,
  }) {
    final Match match = _getMatch(json.matchId);
    match.deployUnit(
      socket: socket,
      location: json.location,
      type: json.type,
    );
  }

  Match _getMatch(String matchId) {
    if (hasMatch(matchId)) {
      return matches.get(matchId);
    } else {
      throw JsonMessage.error('Match with ID $matchId does not exist');
    }
  }

  void update(double dt) {
    for (final Match match in matches) {
      match.update(dt);
    }
  }
}
