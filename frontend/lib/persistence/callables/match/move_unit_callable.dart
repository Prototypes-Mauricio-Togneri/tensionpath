import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_event.dart';
import 'package:tensionpath/domain/json/json_match.dart';
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

    final JsonMatch json = JsonUtils.matchMoveUnit(
      match: match,
      unitOrigin: unit,
      nodeOrigin: nodeOrigin,
      nodeTarget: nodeTarget,
    );
    await MatchRepository.update(
      json: json,
      event: JsonEvent.moveUnit(
        nodeIdOrigin: nodeOrigin.id,
        nodeIdTarget: nodeTarget.id,
      ),
    );
  }
}
