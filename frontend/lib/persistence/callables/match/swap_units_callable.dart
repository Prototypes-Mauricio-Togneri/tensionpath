import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class SwapUnitsCallable {
  Future call({
    required Match match,
    required Unit unitOrigin,
    required Unit unitTarget,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) async {
    if (!match.self.hasResources(
      unitOrigin.type.movementCost + unitTarget.type.movementCost,
    )) {
      throw Exception('Insufficient funds');
    }

    final JsonMatch json = JsonUtils.matchSwapUnits(
      match: match,
      unitOrigin: unitOrigin,
      unitTarget: unitTarget,
      nodeOrigin: nodeOrigin,
      nodeTarget: nodeTarget,
    );
    await MatchRepository.update(json);
  }
}
