import 'package:flame/palette.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Base with GameEngineRef {
  final Player owner;
  double health;

  Base({
    required this.owner,
    required this.health,
  });

  Color get color => owner.color;

  void onHit(double value) {
    health -= value;
    health = health.clamp(0, 100);

    if (health <= 0) {
      engine.onBaseDestroyed(this);
    }
  }
}
