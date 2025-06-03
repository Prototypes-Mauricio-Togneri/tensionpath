import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_units.dart';
import 'package:tensionpath/domain/types/action_type.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      /*
      final JsonBattlefield jsonBattlefield = _nextBattlefield(
        jsonBattlefield: jsonMatch.battlefield,
        jsonPlayers: playersUpdated,
      );

      return JsonMatch(
        id: jsonMatch.id,
        version: jsonMatch.version,
        createdAt: jsonMatch.createdAt,
        config: jsonMatch.config,
        turn: _nextTurn(jsonMatch.turn),
        players: _nextPlayers(
          jsonPlayers: playersUpdated,
          jsonBattlefield: jsonBattlefield,
          jsonConfig: jsonMatch.config,
        ),
        battlefield: jsonBattlefield,
      );*/
      return _updateMatch(jsonMatch);
    } else {
      return jsonMatch;
    }
  }

  // Update steps:
  // * Check if the missile is full and launch it + update base health
  // * If both players are alive, continue. If not, skip.
  // * Calculate unit deployments
  // * Calculate unit movements
  //    * Update player base health in case of attack
  // * Update players
  //    * Update resources
  //    * Reset player
  //       * Set status to playing
  //       * Clear turnEndedAt
  //       * Clear actions
  // * Update missile
  //    * Update charge
  //    * Update platform owners
  //    * Update missile owner
  // * Update turn
  //    * Increase turn counter
  //    * Set turn started at
  static JsonMatch _updateMatch(JsonMatch jsonMatch) {
    _checkMissile(
      jsonMissile: jsonMatch.battlefield.missile,
      jsonPlayers: jsonMatch.players,
      jsonConfig: jsonMatch.config,
    );

    if (_checkPlayersAlive(jsonMatch.players.values.toList())) {
      final Map<String, JsonNode> jsonNodes = Map.fromEntries(
        jsonMatch.battlefield.nodes.map(
          (node) => MapEntry(_locationId(node.x, node.y), node),
        ),
      );
      final List<JsonAction> jsonActions = jsonMatch.players.values
          .expand((p) => p.actions)
          .toList();

      // Implement
      _executeUnitDeployments(
        jsonNodes: jsonNodes,
        jsonActions: jsonActions
            .where((a) => a.type == ActionType.deploy)
            .toList(),
      );

      _executeUnitMovements(
        jsonNodes: jsonNodes,
        jsonPlayers: jsonMatch.players,
        jsonActions: jsonActions
            .where((a) => a.type == ActionType.move)
            .toList(),
      );

      _updatePlayerResources(
        jsonPlayers: jsonMatch.players,
        jsonNodes: jsonMatch.battlefield.nodes,
        jsonConfig: jsonMatch.config,
      );

      _resetPlayers(jsonMatch.players);

      _updateMissile(jsonMatch.battlefield.missile);

      _updateTurn(jsonMatch.turn);
    }

    return jsonMatch;
  }

  static void _checkMissile({
    required JsonMissile jsonMissile,
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonConfig jsonConfig,
  }) {
    if (_isMissileFull(jsonMissile)) {
      for (final MapEntry<String, JsonPlayer> entry in jsonPlayers.entries) {
        final String playerId = entry.key;
        final JsonPlayer player = entry.value;

        if (jsonMissile.owner != playerId) {
          player.baseHealth -= jsonConfig.baseMaxHealth ~/ 2;
        }
      }
    }
  }

  static bool _isMissileFull(JsonMissile missile) =>
      (missile.charge == missile.maxCharge) &&
      ((missile.owner != '') || (missile.owner != null));

  static bool _checkPlayersAlive(List<JsonPlayer> jsonPlayers) {
    for (final JsonPlayer jsonPlayer in jsonPlayers) {
      if (jsonPlayer.baseHealth <= 0) {
        return false;
      }
    }

    return true;
  }

  static void _executeUnitDeployments({
    required Map<String, JsonNode> jsonNodes,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction action in jsonActions) {
      final String locationId = _locationId(action.targetX, action.targetY);
      final JsonNode jsonNode = jsonNodes[locationId]!;
      jsonNode.units = JsonUnits(
        playerId: action.playerId,
        amount: action.amount!,
      );
    }
  }

  static void _executeUnitMovements({
    required Map<String, JsonNode> jsonNodes,
    required Map<String, JsonPlayer> jsonPlayers,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction action in jsonActions) {
      final String originLocationId = _locationId(
        action.originX!,
        action.originY!,
      );
      final JsonNode originNode = jsonNodes[originLocationId]!;

      final String targetLocationId = _locationId(
        action.targetX,
        action.targetY,
      );
      final JsonNode targetNode = jsonNodes[targetLocationId]!;

      _nextNodesMovement(
        originNode: originNode,
        targetNode: targetNode,
        action: action,
        jsonPlayers: jsonPlayers,
      );
    }
  }

  static void _nextNodesMovement({
    required JsonNode originNode,
    required JsonNode targetNode,
    required JsonAction action,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final JsonUnits sourceUnits = originNode.units!;
    final JsonUnits? targetUnits = targetNode.units;

    if (targetUnits == null) {
      // Target node is empty
      targetNode.units = JsonUnits(
        playerId: action.playerId,
        amount: sourceUnits.amount,
      );
    } else {
      if (sourceUnits.playerId == targetUnits.playerId) {
        // Same player's unit in source and target
        targetUnits.amount += sourceUnits.amount;
      } else {
        // Battle between players units
        if (sourceUnits.amount > targetUnits.amount) {
          // Source node has more units
          targetUnits.amount = sourceUnits.amount - targetUnits.amount;
          targetUnits.playerId = sourceUnits.playerId;
        } else if (sourceUnits.amount < targetUnits.amount) {
          // Target node has more units
          targetUnits.amount = targetUnits.amount - sourceUnits.amount;
          targetUnits.playerId = targetUnits.playerId;
        } else {
          // All units are destroyed
          originNode.units = null;
          targetNode.units = null;
        }
      }
    }

    originNode.units = null;

    final JsonStructure? targetNodeStructure = targetNode.structure;

    if (targetNodeStructure != null &&
        targetNodeStructure.type == StructureType.launcher) {
      final JsonUnits targetUnitsAfterBattle = targetNode.units!;

      if (targetUnitsAfterBattle.playerId != targetNodeStructure.playerId) {
        // Attack player's base
        final JsonPlayer player = jsonPlayers[targetNodeStructure.playerId!]!;
        jsonPlayers[targetNodeStructure.playerId!] = JsonPlayer(
          name: player.name,
          baseHealth: player.baseHealth - targetUnitsAfterBattle.amount,
          resources: player.resources,
          status: player.status,
          turnEndedAt: player.turnEndedAt,
          actions: player.actions,
        );

        targetNode.units = null;
      }
    }
  }

  static void _updatePlayerResources({
    required Map<String, JsonPlayer> jsonPlayers,
    required List<JsonNode> jsonNodes,
    required JsonConfig jsonConfig,
  }) {
    final JsonPlayer jsonPlayer1 = jsonPlayers[Constants.PLAYER_1]!;
    final JsonPlayer jsonPlayer2 = jsonPlayers[Constants.PLAYER_2]!;

    jsonPlayer1.resources += jsonConfig.resourcesPerTurn;
    jsonPlayer2.resources += jsonConfig.resourcesPerTurn;

    final DateTime player1TurnEndedAt = jsonPlayer1.turnEndedAt!;
    final DateTime player2TurnEndedAt = jsonPlayer2.turnEndedAt!;

    if (player1TurnEndedAt.isAfter(player2TurnEndedAt)) {
      final int diffSeconds = player1TurnEndedAt
          .difference(player2TurnEndedAt)
          .inSeconds;
      jsonPlayer2.resources += (diffSeconds * jsonConfig.resourcesPerSecond)
          .floor();
    } else if (player2TurnEndedAt.isAfter(player1TurnEndedAt)) {
      final int diffSeconds = player2TurnEndedAt
          .difference(player1TurnEndedAt)
          .inSeconds;
      jsonPlayer1.resources += (diffSeconds * jsonConfig.resourcesPerSecond)
          .floor();
    }

    for (final JsonNode jsonNode in jsonNodes) {
      if ((jsonNode.structure != null) &&
          (jsonNode.structure!.type == StructureType.resources) &&
          (jsonNode.units != null)) {
        final JsonPlayer jsonPlayer = jsonPlayers[jsonNode.units!.playerId]!;
        jsonPlayer.resources += jsonConfig.resourcesPerPatch;
      }
    }
  }

  static void _resetPlayers(Map<String, JsonPlayer> jsonPlayers) {
    for (final JsonPlayer jsonPlayer in jsonPlayers.values) {
      jsonPlayer.status = PlayerStatus.playing;
      jsonPlayer.turnEndedAt = null;
      jsonPlayer.actions.clear();
    }
  }

  static void _updateMissile(JsonMissile jsonMissile) {
    if (_isMissileFull(jsonMissile)) {
      jsonMissile.charge = 0;
    } else {
      // TODO(momo): update values
      //platforms: jsonMissile.platforms,
      //owner: jsonMissile.owner,

      jsonMissile.charge = _nextMissileCharge(jsonMissile);
    }
  }

  static int _nextMissileCharge(JsonMissile missile) {
    final bool charging =
        missile.owner == Constants.PLAYER_1 ||
        missile.owner == Constants.PLAYER_2;

    if (charging) {
      return missile.charge + 1;
    } else if ((missile.owner == '') &&
        (missile.charge > missile.bufferCharge)) {
      return missile.charge - 1;
    } else {
      return missile.charge;
    }
  }

  static void _updateTurn(JsonTurn jsonTurn) {
    jsonTurn.turn += 1;
    jsonTurn.startedAt = DateTime.now();
  }

  static String _locationId(int x, int y) => '$x,$y';
}
