import 'package:flame/palette.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Base {
  final Player player;
  int hp;

  Base({
    required this.player,
    required this.hp,
  });

  Color get color => player.color;

  void onHit(int value) {
    hp -= value;
    hp = hp.clamp(0, 100);

    if (hp <= 0) {
      GameState.instance.onBaseDestroyed(this);
    }
  }
}
