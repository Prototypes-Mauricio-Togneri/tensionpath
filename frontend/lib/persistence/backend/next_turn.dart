import 'dart:math';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/domain/types/action_type.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    if (_allPlayersWaiting(jsonMatch)) {
      return _updateMatch(jsonMatch);
    } else {
      return jsonMatch;
    }
  }

  bool _allPlayersWaiting(JsonMatch jsonMatch) =>
      jsonMatch.players.values.every((p) => p.status == PlayerStatus.waiting);

  // Update steps:
  // * Check if the missile is full and launch it + update base health
  // * If both players are alive, continue. If not, skip.
  // * Execute unit deployments
  // * Execute unit movements
  //    * Update player base health in case of attack
  // * Update players resources
  // * Update missile
  //    * Update charge
  //    * Update platform owners
  //    * Update missile owner
  // * Reset players
  //    * Set status to playing
  //    * Clear turnEndedAt
  //    * Clear actions
  // * Update turn
  //    * Increase turn counter
  //    * Set turn started at
  JsonMatch _updateMatch(JsonMatch jsonMatch) {
    _checkMissile(
      jsonMissile: jsonMatch.battlefield.missile,
      jsonPlayers: jsonMatch.players,
      jsonConfig: jsonMatch.config,
    );

    if (_checkPlayersAlive(jsonMatch.players)) {
      final Map<String, JsonNode> jsonNodes = Map.fromEntries(
        jsonMatch.battlefield.nodes.map(
          (node) => MapEntry(_locationId(node.x, node.y), node),
        ),
      );
      final List<JsonAction> jsonActions = jsonMatch.players.values
          .expand((p) => p.actions)
          .toList();

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
        jsonConfig: jsonMatch.config,
      );

      _updatePlayerResources(
        jsonPlayers: jsonMatch.players,
        jsonNodes: jsonMatch.battlefield.nodes,
        jsonConfig: jsonMatch.config,
      );

      _updateMissile(
        jsonMissile: jsonMatch.battlefield.missile,
        jsonNodes: jsonMatch.battlefield.nodes,
      );
    }

    _resetPlayers(jsonMatch.players);

    _updateTurn(jsonMatch.turn);

    return jsonMatch;
  }

  void _checkMissile({
    required JsonMissile jsonMissile,
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonConfig jsonConfig,
  }) {
    if (_isMissileFull(jsonMissile)) {
      for (final MapEntry<String, JsonPlayer> entry in jsonPlayers.entries) {
        final String playerId = entry.key;
        final JsonPlayer jsonPlayer = entry.value;

        if (jsonMissile.owner != playerId) {
          jsonPlayer.baseHealth -= jsonConfig.baseMaxHealth ~/ 2;

          if (jsonPlayer.baseHealth < 0) {
            jsonPlayer.baseHealth = 0;
          }
        }
      }
    }
  }

  bool _checkPlayersAlive(Map<String, JsonPlayer> jsonPlayers) {
    for (final JsonPlayer jsonPlayer in jsonPlayers.values) {
      if (jsonPlayer.baseHealth <= 0) {
        return false;
      }
    }

    return true;
  }

  void _executeUnitDeployments({
    required Map<String, JsonNode> jsonNodes,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction jsonAction in jsonActions) {
      final String locationId = _locationId(
        jsonAction.targetX,
        jsonAction.targetY,
      );
      final JsonNode jsonNode = jsonNodes[locationId]!;
      jsonNode.unit = JsonUnit(
        playerId: jsonAction.playerId,
        level: jsonAction.level!,
      );
    }
  }

  void _executeUnitMovements({
    required Map<String, JsonNode> jsonNodes,
    required Map<String, JsonPlayer> jsonPlayers,
    required List<JsonAction> jsonActions,
    required JsonConfig jsonConfig,
  }) {
    _resetTemporaryUnits(jsonNodes);
    _fillTemporaryUnits(jsonNodes: jsonNodes, jsonActions: jsonActions);
    _resolveBattles(
      jsonNodes: jsonNodes,
      jsonPlayers: jsonPlayers,
      jsonConfig: jsonConfig,
    );
    _checkBaseAttacks(jsonNodes: jsonNodes, jsonPlayers: jsonPlayers);
  }

  void _resetTemporaryUnits(Map<String, JsonNode> jsonNodes) {
    for (final JsonNode jsonNode in jsonNodes.values) {
      jsonNode.temporaryUnits.clear();
    }
  }

  void _fillTemporaryUnits({
    required Map<String, JsonNode> jsonNodes,
    required List<JsonAction> jsonActions,
  }) {
    for (final JsonAction jsonAction in jsonActions) {
      final String originLocationId = _locationId(
        jsonAction.originX!,
        jsonAction.originY!,
      );
      final JsonNode originNode = jsonNodes[originLocationId]!;

      final String targetLocationId = _locationId(
        jsonAction.targetX,
        jsonAction.targetY,
      );
      final JsonNode targetNode = jsonNodes[targetLocationId]!;

      final JsonUnit jsonUnit = originNode.unit!;
      jsonUnit.hasMoved = true;

      targetNode.temporaryUnits.add(jsonUnit);
      originNode.unit = null;
    }

    for (final JsonNode jsonNode in jsonNodes.values) {
      if (jsonNode.unit != null) {
        final JsonUnit jsonUnit = jsonNode.unit!;
        jsonUnit.hasMoved = false;

        jsonNode.temporaryUnits.add(jsonUnit);
        jsonNode.unit = null;
      }
    }
  }

  void _resolveBattles({
    required Map<String, JsonNode> jsonNodes,
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonConfig jsonConfig,
  }) {
    for (final JsonNode jsonNode in jsonNodes.values) {
      if (jsonNode.temporaryUnits.length == 1) {
        // Only one unit in the node, no battle
        final JsonUnit jsonUnit = jsonNode.temporaryUnits.first;
        jsonUnit.hasMoved = false;

        jsonNode.unit = jsonUnit;
      } else if (jsonNode.temporaryUnits.length > 1) {
        // More than one unit in the node, resolve battle
        _resolveBattle(jsonNode: jsonNode, jsonConfig: jsonConfig);
      }

      jsonNode.temporaryUnits.clear();
    }
  }

  void _resolveBattle({
    required JsonNode jsonNode,
    required JsonConfig jsonConfig,
  }) {
    int player1Units = 0;
    int player2Units = 0;
    bool player1Moved = false;
    bool player2Moved = false;

    for (final JsonUnit jsonUnit in jsonNode.temporaryUnits) {
      if (jsonUnit.playerId == Constants.PLAYER_1) {
        player1Units += jsonUnit.level;
        player1Moved |= jsonUnit.hasMoved;
      } else if (jsonUnit.playerId == Constants.PLAYER_2) {
        player2Units += jsonUnit.level;
        player2Moved |= jsonUnit.hasMoved;
      }
    }

    final int player1EffectiveUnits = player1Moved
        ? player1Units
        : (player1Units * 1.1).ceil();
    final int player2EffectiveUnits = player2Moved
        ? player2Units
        : (player2Units * 1.1).ceil();

    if (player1EffectiveUnits > player2EffectiveUnits) {
      final int remainingUnits = player1EffectiveUnits - player2EffectiveUnits;

      // Player 1 wins
      jsonNode.unit = JsonUnit(
        playerId: Constants.PLAYER_1,
        level: min(remainingUnits, player1Units),
      );
    } else if (player2EffectiveUnits > player1EffectiveUnits) {
      final int remainingUnits = player2EffectiveUnits - player1EffectiveUnits;

      // Player 2 wins
      jsonNode.unit = JsonUnit(
        playerId: Constants.PLAYER_2,
        level: min(remainingUnits, player2Units),
      );
    } else {
      // Both players lose all units
      jsonNode.unit = null;
    }
  }

  void _checkBaseAttacks({
    required Map<String, JsonNode> jsonNodes,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    for (final JsonNode jsonNode in jsonNodes.values) {
      if ((jsonNode.structure != null) &&
          (jsonNode.unit != null) &&
          (jsonNode.structure!.type == StructureType.launcher) &&
          (jsonNode.unit!.playerId != jsonNode.structure!.playerId)) {
        final JsonPlayer jsonPlayer =
            jsonPlayers[jsonNode.structure!.playerId]!;
        jsonPlayer.baseHealth -= jsonNode.unit!.level;

        if (jsonPlayer.baseHealth < 0) {
          jsonPlayer.baseHealth = 0;
        }

        jsonNode.unit = null;
      }
    }
  }

  void _updatePlayerResources({
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
          (jsonNode.unit != null)) {
        final JsonPlayer jsonPlayer = jsonPlayers[jsonNode.unit!.playerId]!;
        final int newResources = jsonNode.unit!.level.clamp(
          0,
          jsonConfig.resourcesPerPatch,
        );
        jsonPlayer.resources += newResources;
      }
    }
  }

  void _resetPlayers(Map<String, JsonPlayer> jsonPlayers) {
    for (final JsonPlayer jsonPlayer in jsonPlayers.values) {
      jsonPlayer.status = PlayerStatus.playing;
      jsonPlayer.turnEndedAt = null;
      jsonPlayer.actions.clear();
    }
  }

  void _updateMissile({
    required JsonMissile jsonMissile,
    required List<JsonNode> jsonNodes,
  }) {
    final Map<String, String?> jsonPlatforms = jsonMissile.platforms;
    int player1 = 0;
    int player2 = 0;
    int none = 0;

    for (final String platformId in jsonPlatforms.keys) {
      final String? platformOwner = _platformOwner(
        platformId: platformId,
        jsonNodes: jsonNodes,
      );
      jsonPlatforms[platformId] = platformOwner;

      if (platformOwner == Constants.PLAYER_1) {
        player1++;
      } else if (platformOwner == Constants.PLAYER_2) {
        player2++;
      } else if (platformOwner == null) {
        none++;
      }
    }

    if (none == jsonMissile.numberOfPlatforms) {
      jsonMissile.owner = null;
    } else if (player1 > player2) {
      jsonMissile.owner = Constants.PLAYER_1;
    } else if (player2 > player1) {
      jsonMissile.owner = Constants.PLAYER_2;
    } else if (player1 == player2) {
      jsonMissile.owner = '';
    }

    if (_isMissileFull(jsonMissile)) {
      jsonMissile.charge = 0;
    } else {
      jsonMissile.charge = _nextMissileCharge(jsonMissile);
    }
  }

  String? _platformOwner({
    required String platformId,
    required List<JsonNode> jsonNodes,
  }) {
    final List<JsonNode> platformNodes = _platformNodes(
      platformId: platformId,
      jsonNodes: jsonNodes,
    );

    int player1 = 0;
    int player2 = 0;

    for (final JsonNode jsonNode in platformNodes) {
      if (jsonNode.unit?.playerId == Constants.PLAYER_1) {
        player1++;
      } else if (jsonNode.unit?.playerId == Constants.PLAYER_2) {
        player2++;
      }
    }

    if ((player1 > 0) && (player2 == 0)) {
      return Constants.PLAYER_1;
    } else if ((player2 > 0) && (player1 == 0)) {
      return Constants.PLAYER_2;
    } else if ((player1 > 0) && (player2 > 0)) {
      return '';
    } else {
      return null;
    }
  }

  List<JsonNode> _platformNodes({
    required String platformId,
    required List<JsonNode> jsonNodes,
  }) {
    return jsonNodes
        .where((node) => node.structure?.platformId == platformId)
        .toList();
  }

  bool _isMissileFull(JsonMissile jsonMissile) =>
      (jsonMissile.charge == jsonMissile.maxCharge) &&
      _isMissileCharging(jsonMissile);

  bool _isMissileCharging(JsonMissile jsonMissile) =>
      (jsonMissile.owner != '') && (jsonMissile.owner != null);

  int _nextMissileCharge(JsonMissile jsonMissile) {
    if (_isMissileCharging(jsonMissile)) {
      return jsonMissile.charge + 1;
    } else if ((jsonMissile.owner == '') &&
        (jsonMissile.charge > jsonMissile.bufferCharge)) {
      return jsonMissile.charge - 1;
    } else {
      return jsonMissile.charge;
    }
  }

  void _updateTurn(JsonTurn jsonTurn) {
    jsonTurn.turn += 1;
    jsonTurn.startedAt = DateTime.now();
  }

  String _locationId(int x, int y) => '$x,$y';
}
