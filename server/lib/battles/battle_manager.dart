import 'dart:io';
import 'package:tensionpath/battles/battle.dart';
import 'package:tensionpath/domain/json/api/json_create_battle.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_join_battle.dart';
import 'package:tensionpath/domain/json/messages/client_server/json_launch_units.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/utils/map_list.dart';

class BattleManager {
  final MapList<String, Battle> battles = MapList();
  final Map<WebSocket, Battle> websocketToBattle = {};

  bool hasBattle(String battleId) => battles.has(battleId);

  void create(JsonCreateBattle json) {
    final Battle battle = Battle.fromJson(json);
    battles.add(json.battleId, battle);
  }

  void join({
    required JsonJoinBattle json,
    required WebSocket socket,
  }) {
    final Battle battle = _getBattle(json.battleId);
    battle.join(
      playerId: json.playerId,
      socket: socket,
    );
    websocketToBattle[socket] = battle;
  }

  void leave(WebSocket socket) {
    if (websocketToBattle.containsKey(socket)) {
      final Battle battle = websocketToBattle[socket]!;
      battle.leave(socket);
      websocketToBattle.remove(socket);

      if (battle.isEmpty) {
        battles.remove(battle.id, battle);
      }
    } else {
      throw JsonMessage.error('Connection not linked with any battle');
    }
  }

  void launchUnits({
    required JsonLaunchUnits json,
    required WebSocket socket,
  }) {
    final Battle battle = _getBattle(json.battleId);
    battle.launchUnits(socket, json.laneId, json.amount);
  }

  Battle _getBattle(String battleId) {
    if (hasBattle(battleId)) {
      return battles.get(battleId);
    } else {
      throw JsonMessage.error('Battle with ID $battleId does not exist');
    }
  }

  void update(double dt) {
    for (final Battle battle in battles) {
      battle.update(dt);
    }
  }
}
