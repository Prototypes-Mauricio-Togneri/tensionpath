import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/player_status.dart';

class NextTurn {
  Future<JsonMatch> call(JsonMatch jsonMatch) async {
    final bool allWaiting = jsonMatch.players.values.every(
      (p) => p.status == PlayerStatus.waiting,
    );

    if (allWaiting) {
      /*final Map<String, JsonPlayer> playersUpdated = _checkMissileLaunch(
        jsonPlayers: jsonMatch.players,
        jsonBattlefield: jsonMatch.battlefield,
        jsonConfig: jsonMatch.config,
      );

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
  // * Update players resources
  // * Update missile
  //    * Update charge
  //    * Update platform owners
  //    * Update missile owner
  // * Update turn
  //    * Increase turn counter
  //    * Set turn started at
  // * Reset players
  //    * Clear actions
  //    * Clear turnEndedAt
  //    * Set status to playing
  static JsonMatch _updateMatch(JsonMatch jsonMatch) {
    _checkMissile(
      jsonMissile: jsonMatch.battlefield.missile,
      jsonPlayers: jsonMatch.players,
      jsonConfig: jsonMatch.config,
    );

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

  /*static JsonTurn _nextTurn(JsonTurn jsonTurn) =>
      JsonTurn(turn: jsonTurn.turn + 1, startedAt: DateTime.now());

  static Map<String, JsonPlayer> _nextPlayers({
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonBattlefield jsonBattlefield,
    required JsonConfig jsonConfig,
  }) {
    final DateTime player1TurnEndedAt =
        jsonPlayers[Constants.PLAYER_1]!.turnEndedAt!;
    final DateTime player2TurnEndedAt =
        jsonPlayers[Constants.PLAYER_2]!.turnEndedAt!;

    final Map<String, int> extraResources = {
      Constants.PLAYER_1: jsonConfig.resourcesPerTurn,
      Constants.PLAYER_2: jsonConfig.resourcesPerTurn,
    };

    if (player1TurnEndedAt.isAfter(player2TurnEndedAt)) {
      final int diffSeconds = player1TurnEndedAt
          .difference(player2TurnEndedAt)
          .inSeconds;
      extraResources[Constants.PLAYER_2] =
          extraResources[Constants.PLAYER_2]! +
          (diffSeconds * jsonConfig.resourcesPerSecond.floor());
    } else if (player2TurnEndedAt.isAfter(player1TurnEndedAt)) {
      final int diffSeconds = player2TurnEndedAt
          .difference(player1TurnEndedAt)
          .inSeconds;
      extraResources[Constants.PLAYER_1] =
          extraResources[Constants.PLAYER_1]! +
          (diffSeconds * jsonConfig.resourcesPerSecond.floor());
    }

    for (final JsonNode jsonNode in jsonBattlefield.nodes) {
      if ((jsonNode.structure != null) &&
          (jsonNode.structure!.type == StructureType.resources) &&
          (jsonNode.units != null)) {
        extraResources[jsonNode.units!.playerId] =
            extraResources[jsonNode.units!.playerId]! +
            jsonConfig.resourcesPerPatch;
      }
    }

    return Map.fromEntries(
      jsonPlayers.entries.map(
        (entry) => MapEntry(
          entry.key,
          _nextPlayer(
            jsonPlayer: entry.value,
            extraResources: extraResources[entry.key]!,
          ),
        ),
      ),
    );
  }

  static Map<String, JsonPlayer> _checkMissileLaunch({
    required Map<String, JsonPlayer> jsonPlayers,
    required JsonBattlefield jsonBattlefield,
    required JsonConfig jsonConfig,
  }) => Map.fromEntries(
    jsonPlayers.entries.map(
      (entry) => MapEntry(
        entry.key,
        _nextPlayerDamage(
          jsonPlayer: entry.value,
          damange: _missileHit(
            playerId: entry.key,
            baseMaxHealth: jsonConfig.baseMaxHealth,
            jsonMissile: jsonBattlefield.missile,
          ),
        ),
      ),
    ),
  );

  static JsonPlayer _nextPlayer({
    required JsonPlayer jsonPlayer,
    required int extraResources,
  }) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: jsonPlayer.baseHealth,
    resources: jsonPlayer.resources + extraResources,
    status: PlayerStatus.playing,
    turnEndedAt: null,
    actions: [],
  );

  static JsonPlayer _nextPlayerDamage({
    required JsonPlayer jsonPlayer,
    required int damange,
  }) => JsonPlayer(
    name: jsonPlayer.name,
    baseHealth: jsonPlayer.baseHealth - damange,
    resources: jsonPlayer.resources,
    status: jsonPlayer.status,
    turnEndedAt: jsonPlayer.turnEndedAt,
    actions: jsonPlayer.actions,
  );

  static int _missileHit({
    required String playerId,
    required int baseMaxHealth,
    required JsonMissile jsonMissile,
  }) {
    if (_missileFull(jsonMissile)) {
      if (jsonMissile.owner != playerId) {
        return baseMaxHealth ~/ 2;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  static JsonBattlefield _nextBattlefield({
    required JsonBattlefield jsonBattlefield,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final Map<String, JsonNode> nodesById = Map.fromEntries(
      jsonBattlefield.nodes.map(
        (node) => MapEntry(_locationId(node.x, node.y), node),
      ),
    );

    final List<JsonNode> jsonNodes = _nextNodes(
      nodesById: nodesById,
      jsonPlayers: jsonPlayers,
    );

    return JsonBattlefield(
      id: jsonBattlefield.id,
      size: jsonBattlefield.size,
      missile: _nextMissile(
        jsonMissile: jsonBattlefield.missile,
        jsonNodes: jsonNodes,
        jsonPlayers: jsonPlayers,
      ),
      nodes: jsonNodes,
    );
  }

  static JsonMissile _nextMissile({
    required JsonMissile jsonMissile,
    required List<JsonNode> jsonNodes,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    if (_missileFull(jsonMissile)) {
      return JsonMissile(
        charge: 0,
        maxCharge: jsonMissile.maxCharge,
        bufferCharge: jsonMissile.bufferCharge,
        numberOfPlatforms: jsonMissile.numberOfPlatforms,
        platforms: jsonMissile.platforms,
        owner: jsonMissile.owner,
      );
    } else {
      return JsonMissile(
        charge: _missileNextCharge(jsonMissile),
        maxCharge: jsonMissile.maxCharge,
        bufferCharge: jsonMissile.bufferCharge,
        numberOfPlatforms: jsonMissile.numberOfPlatforms,
        platforms: jsonMissile.platforms,
        owner: jsonMissile.owner,
      );
    }
  }

  static int _missileNextCharge(JsonMissile missile) {
    final String? owner = missile.owner;
    final bool charging =
        owner == Constants.PLAYER_1 || owner == Constants.PLAYER_2;

    if (charging) {
      return missile.charge + 1;
    } else if ((owner == '') && (missile.charge > missile.bufferCharge)) {
      return missile.charge - 1;
    } else {
      return missile.charge;
    }
  }

  static List<JsonNode> _nextNodes({
    required Map<String, JsonNode> nodesById,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    final List<JsonAction> actions = jsonPlayers.values
        .expand((p) => p.actions)
        .toList();

    _nextNodesDeployments(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.deploy).toList(),
    );
    _nextNodesMovements(
      nodesById: nodesById,
      actions: actions.where((a) => a.type == ActionType.move).toList(),
      jsonPlayers: jsonPlayers,
    );

    return nodesById.values.toList();
  }

  static Map<String, JsonNode> _nextNodesDeployments({
    required Map<String, JsonNode> nodesById,
    required List<JsonAction> actions,
  }) {
    for (final JsonAction action in actions) {
      _nextNodeDeployment(
        node: nodesById[_locationId(action.targetX, action.targetY)]!,
        action: action,
      );
    }

    return nodesById;
  }

  static Map<String, JsonNode> _nextNodesMovements({
    required Map<String, JsonNode> nodesById,
    required List<JsonAction> actions,
    required Map<String, JsonPlayer> jsonPlayers,
  }) {
    for (final JsonAction action in actions) {
      _nextNodesMovement(
        originNode: nodesById[_locationId(action.originX!, action.originY!)]!,
        targetNode: nodesById[_locationId(action.targetX, action.targetY)]!,
        action: action,
        jsonPlayers: jsonPlayers,
      );
    }

    return nodesById;
  }

  static void _nextNodeDeployment({
    required JsonNode node,
    required JsonAction action,
  }) {
    node.units = JsonUnits(playerId: action.playerId, amount: action.amount!);
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

  static String _locationId(int x, int y) => '$x,$y';*/
}
