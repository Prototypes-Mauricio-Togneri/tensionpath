import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends SpriteComponent with CollisionCallbacks {
  final Unit unit;

  UnitComponent({
    required this.unit,
    required super.size,
  }) : super(
          sprite: unit.sprite,
          position: unit.position,
          anchor: Anchor.center,
          priority: Priority.units.value,
        );

  Player get owner => unit.owner;

  @override
  FutureOr onLoad() {
    add(circleHitbox);

    return super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is UnitComponent) &&
        unit.owner.isSelf &&
        other.unit.owner.isEnemy) {
      if (unit.power > other.unit.power) {
        unit.reducePower(other.unit.power);
        other.unit.destroy();
      } else if (unit.power < other.unit.power) {
        other.unit.reducePower(unit.power);
        unit.destroy();
      } else {
        unit.destroy();
        other.unit.destroy();
      }
    }

    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    unit.update(dt);

    position = unit.position;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: unit.power.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.white,
    );
  }
}
