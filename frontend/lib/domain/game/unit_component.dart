import 'package:flame/components.dart';
import 'package:tensionpath/domain/game/label_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/unit.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';
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
          priority: Priority.units.value,
        );

  @override
  Future onLoad() async {
    add(LabelComponent(
      text: unit.power.toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.white,
    ));

    super.onLoad();
  }

  @override
  void update(double dt) {
    unit.update(dt);

    position = unit.position;
    //print(position);

    super.update(dt);
  }
}
