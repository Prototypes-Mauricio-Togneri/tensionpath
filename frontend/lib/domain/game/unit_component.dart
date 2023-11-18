import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/utils/sprites.dart';

class UnitComponent extends SpriteComponent {
  final GameState state;
  final Unit unit;

  UnitComponent({
    required this.state,
    required this.unit,
  }) : super(
          sprite: Sprites.UNIT,
          size: Vector2(200, 200),
          position: unit.position,
          anchor: Anchor.center,
        );

  @override
  void update(double dt) {
    unit.update(dt);

    position = unit.position;

    super.update(dt);
  }
}
