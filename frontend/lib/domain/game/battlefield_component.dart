import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/game/lane_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/types/priority.dart';

class BattlefieldComponent extends SpriteComponent {
  final GameState state;
  final Battlefield battlefield;

  BattlefieldComponent({
    required this.state,
    required this.battlefield,
  }) : super(
          position: Vector2(0, 0),
          sprite: battlefield.sprite,
          size: battlefield.sprite.image.size,
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    for (final Lane lane in battlefield.lanes) {
      add(LaneComponent(
        state: state,
        lane: lane,
      ));
    }

    return super.onLoad();
  }
}
