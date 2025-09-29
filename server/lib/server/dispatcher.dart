import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_deploy_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_surrender_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_unit_action.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/iterable_map.dart';

import '../utils/logger.dart';

class Dispatcher {
  final IterableMap<String, Connection> connections = IterableMap();
  final Map<WebSocket, Connection> websocketToConnection = {};

  bool hasConnection(String matchId) => connections.has(matchId);

  void create(JsonCreateMatch json) {
    final Connection connection = Connection.fromJson(json);
    connections.add(connection.matchId, connection);
  }

  void join({
    required JsonJoinMatch json,
    required WebSocket socket,
  }) {
    final Connection connection = _getConnection(json.matchId);
    connection.join(
      playerId: json.playerId,
      socket: socket,
    );
    websocketToConnection[socket] = connection;
  }

  void leave(WebSocket socket) {
    if (websocketToConnection.containsKey(socket)) {
      final Connection connection = websocketToConnection[socket]!;
      connection.leave(socket);
      websocketToConnection.remove(socket);

      if (connection.isEmpty) {
        connections.remove(connection.matchId);
        Logger.log(
          socket,
          'All players left match ${connection.matchId}. Match closed.',
        );
      }
    } else {
      throw JsonMessage.error('Connection not linked with any match');
    }
  }

  void deployUnit({
    required JsonDeployUnit json,
    required WebSocket socket,
  }) {
    final Connection connection = _getConnection(json.matchId);
    connection.deployUnit(
      socket: socket,
      location: json.location,
      type: json.type,
    );
  }

  void unitAction({
    required JsonUnitAction json,
    required WebSocket socket,
  }) {
    final Connection connection = _getConnection(json.matchId);
    connection.unitAction(
      socket: socket,
      unitId: json.unitId,
      targetLocation: json.targetLocation,
      targetUnitId: json.targetUnitId,
    );
  }

  void surrenderMatch({
    required JsonSurrenderMatch json,
    required WebSocket socket,
  }) {
    final Connection connection = _getConnection(json.matchId);
    connection.surrenderMatch(socket);
  }

  Connection _getConnection(String matchId) {
    if (hasConnection(matchId)) {
      return connections.get(matchId);
    } else {
      throw JsonMessage.error('Match $matchId does not exist');
    }
  }

  void update(double dt) {
    for (final Connection connection in connections) {
      connection.update(dt);
    }
  }
}
