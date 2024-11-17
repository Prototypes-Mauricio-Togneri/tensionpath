import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class MatchState extends BaseState {
  late GameState gameState;

  MatchState() {
    restart();
  }

  void restart() {
    final Player self = Player.self();
    final Player enemy = Player.enemy();

    gameState = GameState(
      self: self,
      enemy: enemy,
      battlefield: Battlefield.vector(
        self: self,
        enemy: enemy,
      ),
      matchState: this,
    );
    
    notify();
  }
}
