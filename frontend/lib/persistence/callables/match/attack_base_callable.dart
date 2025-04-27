import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_event.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class AttackBaseCallable {
  Future call({
    required Match match,
    required Unit unit,
    required Node node,
  }) async {
    final JsonMatch json = JsonUtils.matchAttackBase(
      match: match,
      unit: unit,
      node: node,
    );
    await MatchRepository.update(
      json: json,
      event: JsonEvent.attackBase(
        nodeIdOrigin: unit.getLocation.id,
        nodeIdTarget: node.id,
      ),
    );
  }
}
