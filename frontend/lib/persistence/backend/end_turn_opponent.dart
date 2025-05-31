import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurnOpponent {
  Future call(Match match) async {
    final JsonMatch json = _endTurnOpponent(match);
    await MatchRepository.update(json);
  }

  JsonMatch _endTurnOpponent(Match match) {
    return JsonMatch(
      id: match.id,
      version: match.version,
      createdAt: match.createdAt,
      config: JsonUtils.configToJson(match.config),
      turn: JsonUtils.turnToJson(match.turn),
      players: {
        match.self.id: JsonUtils.playerToJson(match.self),
        match.opponent.id: JsonUtils.playerUpdate(
          player: match.opponent,
          baseMaxHealth: match.config.baseMaxHealth,
          resourcesChange: match.opponent.resources,
          healthChange: 0,
          turnEndedAt: DateTime.now(),
        ),
      },
      battlefield: JsonUtils.battlefieldToJson(match.battlefield),
    );
  }
}
