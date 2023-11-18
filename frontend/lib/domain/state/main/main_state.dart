import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';

class MainState extends BaseState {
  GameState get gameState => GameState(battlefield: Battlefield.test());

  void onCommandPointsSelected(int amount) => gameState.onCommandPointsSelected(amount);
}
