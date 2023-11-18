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
  LabelComponent? labelComponent;

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
    refresh();

    super.onLoad();
  }

  @override
  void update(double dt) {
    unit.update(dt);

    position = unit.position;

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
