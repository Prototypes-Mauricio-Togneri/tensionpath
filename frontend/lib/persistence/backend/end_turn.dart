import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class EndTurn {
  Future call(Match match) async {
    final JsonMatch json = _endTurnSelf(match);
    await MatchRepository.update(json);
  }

  JsonMatch _endTurnSelf(Match match) => JsonMatch(
    id: match.id,
    version: match.version,
    createdAt: match.createdAt,
    config: JsonUtils.configToJson(match.config),
    turn: JsonUtils.turnToJson(match.turn),
    players: {
      match.self.id: JsonUtils.playerUpdate(
        player: match.self,
        baseMaxHealth: match.config.baseMaxHealth,
        resourcesChange: match.self.resources,
        healthChange: 0,
        turnEndedAt: DateTime.now(),
      ),
      match.opponent.id: JsonUtils.playerToJson(match.opponent),
    },
    battlefield: JsonUtils.battlefieldWithActions(match.battlefield),
  );
}
