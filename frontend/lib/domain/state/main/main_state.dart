import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/utils/sprites.dart';

class MainState extends BaseState {
  GameState get gameState => GameState(mapSprite: Sprites.MAP);

  void onDeployUnits(int value) {}
}
