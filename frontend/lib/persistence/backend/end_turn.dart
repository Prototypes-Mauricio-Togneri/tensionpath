import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurn {
  Future call(Match match) async {
    final JsonMatch json = JsonUtils.endTurnSelf(match);
    await MatchRepository.update(json);
  }
}
