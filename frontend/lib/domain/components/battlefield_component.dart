import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/types/priority.dart';

class BattlefieldComponent extends PositionComponent {
  final Battlefield battlefield;
  final Paint paintBackground = Paint();
  final Paint paintLanes = Paint();

  BattlefieldComponent({
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

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, width, height),
      paintBackground,
    );

    canvas.drawLine(
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
    );
  }
}
