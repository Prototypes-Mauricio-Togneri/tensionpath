import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/lane_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
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

    for (final NodeComponent node in battlefield.nodes) {
      add(node);
    }

    add(LaneComponent(
      player: state.self,
      color: Colors.pink,
      position: Vector2(0, 0),
      size: Vector2(200, battlefield.mapSize.y),
    ));

    add(LaneComponent(
      player: state.self,
      color: Colors.yellow,
      position: Vector2(200, 0),
      size: Vector2(200, battlefield.mapSize.y),
    ));

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

    /*canvas.drawLine(
        const Offset(0, 0),
        Offset(0, height),
        paintLanes,
      );

    canvas.drawLine(
      const Offset(200, 0),
      Offset(200, height),
      paintLanes,
    );

    canvas.drawLine(
      const Offset(400, 0),
      Offset(400, height),
      paintLanes,
    );

    canvas.drawLine(
      const Offset(600, 0),
      Offset(600, height),
      paintLanes,
    );

    canvas.drawLine(
      const Offset(800, 0),
      Offset(800, height),
      paintLanes,
    );

    canvas.drawLine(
      const Offset(1000, 0),
      Offset(1000, height),
      paintLanes,
    );*/
  }
}
