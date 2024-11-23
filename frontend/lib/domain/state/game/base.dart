import 'package:flame/palette.dart';
import 'package:tensionpath/domain/components/target.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class Base with GameEngineRef implements Target {
  final Player owner;
  final double yPosition;
  double health;

  Base({
    required this.owner,
    required this.yPosition,
    required this.health,
  });

  Color get color => owner.color;

  @override
  void onHit(double value) {
    health -= value;
    health = health.clamp(0, 100);

    if (health <= 0) {
      engine.onBaseDestroyed(this);
    }
  }

  @override
  bool get isAlive => health >= 0;

  @override
  bool isInLane(Lane lane) => true;
}
