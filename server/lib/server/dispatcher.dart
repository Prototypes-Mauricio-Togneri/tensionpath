import 'dart:io';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_deploy_unit.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/map_list.dart';

class Dispatcher {
  final MapList<String, Connection> connections = MapList();
  final Map<WebSocket, Connection> websocketToConnection = {};

  bool hasConnection(String matchId) => connections.has(matchId);

  void create(JsonCreateMatch json) {
    final Connection connection = Connection.fromJson(json);
    connections.add(json.matchId, connection);
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
        connections.remove(connection.id, connection);
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
