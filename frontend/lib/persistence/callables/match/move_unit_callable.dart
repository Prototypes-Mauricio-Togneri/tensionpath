import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/extensions/size_extension.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class MoveUnitCallable {
  Future call({
    required Match match,
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) async {
    if (!match.self.hasResources(unit.type.movementCost)) {
      throw Exception('Insufficient funds');
    }

    if (nodeTarget.hasUnit) {
      throw Exception('Node already has a unit');
    }

    final JsonMatch json = match.toJson(
      jsonPlayers: [
        _spendResources(player: match.self, value: unit.type.movementCost),
        JsonUtils.playerToJson(match.opponent),
      ],
      jsonBattlefield: _moveUnit(
        battlefield: match.battlefield,
        unit: unit,
        nodeOrigin: nodeOrigin,
        nodeTarget: nodeTarget,
      ),
    );
    await MatchRepository.update(json);
  }

  JsonPlayer _spendResources({required Player player, required int value}) =>
      JsonPlayer(
        id: player.id,
        name: player.name,
        resources: player.resources - value,
        resourcesRate: player.resourcesRate,
      );

  JsonBattlefield _moveUnit({
    required Battlefield battlefield,
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];
    final Unit unit = nodeOrigin.unit!;

    for (final Node node in battlefield.nodes) {
      if (node == nodeOrigin) {
        jsonNodes.add(nodeOrigin.withUnitUndeployed());
      } else if (node == nodeTarget) {
        jsonNodes.add(nodeTarget.withUnitDeployed(_increaseMoves(unit)));
      } else {
        jsonNodes.add(node.toJson());
      }
    }

    return JsonBattlefield(
      id: battlefield.id,
      size: battlefield.size.toJsonSize(),
      gridRatio: battlefield.gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  JsonUnit _increaseMoves(Unit unit) => JsonUnit(
    type: unit.type,
    health: unit.health,
    moves: unit.remainingMoves - 1,
    player: unit.player.id,
  );
}
