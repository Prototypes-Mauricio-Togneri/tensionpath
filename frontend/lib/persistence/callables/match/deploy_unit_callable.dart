import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class DeployUnitCallable {
  Future call({
    required Match match,
    required Unit unit,
    required Node node,
  }) async {
    if (!match.self.hasResources(unit.type.deploymentCost)) {
      throw Exception('Insufficient funds');
    }

    if (node.hasUnit) {
      throw Exception('Node already has a unit');
    }

    final JsonMatch json = JsonUtils.matchDeployUnit(
      match: match,
      unit: unit,
      node: node,
    );
    await MatchRepository.update(json);
  }
}
