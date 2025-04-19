import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/extensions/size_extension.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class DeployUnitCallable {
  Future call({
    required Match match,
    required Node node,
    required Unit unit,
  }) async {
    if (!match.self.hasResources(unit.type.deploymentCost)) {
      throw Exception('Insufficient funds');
    }

    if (node.hasUnit) {
      throw Exception('Node already has a unit');
    }

    final JsonMatch json = match.toJson(
      jsonPlayers: [
        _spendResources(player: match.self, value: unit.type.deploymentCost),
        match.opponent.toJson(),
      ],
      jsonBattlefield: _deployUnit(
        battlefield: match.battlefield,
        nodeTarget: node,
        unit: unit,
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

  JsonBattlefield _deployUnit({
    required Battlefield battlefield,
    required Node nodeTarget,
    required Unit unit,
  }) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in battlefield.nodes) {
      if (node == nodeTarget) {
        jsonNodes.add(nodeTarget.withUnitDeployed(unit));
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
}
