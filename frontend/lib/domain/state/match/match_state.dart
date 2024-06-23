import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class MatchState extends BaseState {
  late final GameState gameState;

  MatchState(Battlefield battlefield) {
    gameState = GameState(
      self: Player.SELF,
      enemy: Player.ENEMY,
      battlefield: battlefield,
    );
    GameState.instance = gameState;
  }
}
