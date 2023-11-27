import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/game/lane_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends SpriteComponent with CollisionCallbacks {
  final GameState state;
  final Unit unit;
  LabelComponent? labelComponent;

  UnitComponent({
    required this.state,
    required this.unit,
  }) : super(
          sprite: unit.sprite,
          size: Constants.NODE_SIZE,
          position: unit.position,
          anchor: Anchor.center,
          priority: Priority.units.value,
        );

  Player get owner => unit.owner;

  @override
  Future onLoad() async {
    refresh();

    add(CircleHitbox(
      radius: size.x / 2,
      position: size / 2,
      anchor: Anchor.center,
    ));

    super.onLoad();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if ((other is LaneLauncherComponent) && (other.owner != unit.owner)) {
      state.onUnitCollidedWithBase(
        unit: unit,
        baseOwner: other.owner,
      );
    } else if ((other is UnitComponent) &&
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

    if (unit.shouldUpdate) {
      refresh();
    }

    super.update(dt);
  }

  void refresh() {
    if (labelComponent != null) {
      remove(labelComponent!);
    }

    labelComponent = LabelComponent(
      text: unit.power.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.white,
    );

    add(labelComponent!);
  }
}
