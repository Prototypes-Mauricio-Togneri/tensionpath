import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class MainState extends BaseState {
  late final GameState gameState;

  MainState() {
    gameState = GameState(battlefield: Battlefield.test());
  }

  void onCommandPointsSelected(int amount) {
    if (gameState.commandPointsSelected != amount) {
      gameState.onCommandPointsSelected(amount);
    } else {
      gameState.onCommandPointsSelected(0);
    }

    notify();
  }
}
