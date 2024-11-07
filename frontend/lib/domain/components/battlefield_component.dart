import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/lane_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/types/priority.dart';

class BattlefieldComponent extends PositionComponent {
  final GameState state;
  final Battlefield battlefield;
  final Paint paintBackground = Paint();
  final Paint paintLanes = Paint();

  BattlefieldComponent({
    required this.state,
    required this.battlefield,
  }) : super(
          position: Vector2(0, 0),
          size: battlefield.mapSize,
          anchor: Anchor.topLeft,
          priority: Priority.battlefield.value,
        );

  @override
  FutureOr onLoad() {
    paintBackground.color = const Color(0xff000000);

    paintLanes.strokeWidth = 5;
    paintLanes.color = const Color(0xffffffff);

    for (int i = 0; i < battlefield.lanes.length; i++) {
      final Lane lane = battlefield.lanes[i];

      add(LaneComponent(
        lane: lane,
        player: state.self,
        position: Vector2(i * 200, 0),
        size: Vector2(200, battlefield.mapSize.y),
      ));

      for (final Node node in lane.nodes) {
        add(node.component);
      }
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      paintBackground,
    );

    for (int i = 0; i <= battlefield.lanes.length; i++) {
      canvas.drawLine(
        Offset(i * 200, 0),
        Offset(i * 200, height),
        paintLanes,
      );
    }
  }
}
