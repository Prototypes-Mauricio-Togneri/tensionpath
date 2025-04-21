import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class AttackUnitCallable {
  Future call({
    required Match match,
    required Unit unitAttacker,
    required Unit unitDefender,
  }) async {
    final JsonMatch json = JsonUtils.matchAttackUnit(
      match: match,
      unitAttacker: unitAttacker,
      unitDefender: unitDefender,
    );
    await MatchRepository.update(json);
  }
}
