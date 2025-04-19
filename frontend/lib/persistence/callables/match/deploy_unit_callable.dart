import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/extensions/size_extension.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class DeployUnitCallable {
  Future call({
    required Match match,
    required Node node,
    required Unit unit,
  }) async {
    final JsonMatch json = match.toJson(
      jsonBattlefield: _deployUnit(
        battlefield: match.battlefield,
        nodeTarget: node,
        unit: unit,
      ),
    );
    await MatchRepository.update(json);
  }

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
