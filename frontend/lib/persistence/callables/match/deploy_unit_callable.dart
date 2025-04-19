import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class DeployUnitCallable {
  Future call({
    required Match match,
    required Node node,
    required Unit unit,
  }) async {
    final JsonMatch json = match.toJson(
      jsonBattlefield: match.battlefield.deployUnit(
        nodeTarget: node,
        unit: unit,
      ),
    );

    await MatchRepository.update(json);
  }
}
