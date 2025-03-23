import 'dart:async';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_BACKGROUND,
  );

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value);

  @override
  FutureOr onLoad() {
    final double cardWidth = (size.x / 7) * 0.8;
    final double cardHeight = size.y * 0.8;

    final double horizontalGapSize = (size.x - (cardWidth * 7)) / 8;
    final double verticalGapSize = (size.y - cardHeight) / 2;

    add(
      ResourceCounterComponent(
        player: player,
        position: Vector2(horizontalGapSize, verticalGapSize),
        size: Vector2(cardWidth, cardHeight),
      ),
    );

    for (int i = 0; i < 6; i++) {
      final Vector2 position = Vector2(
        ((i + 1.5) * cardWidth) + ((i + 2) * horizontalGapSize),
        verticalGapSize + (cardHeight / 2),
      );

      add(
        UnitSelectorComponent(
          player: player,
          unitType: UnitType.infantry,
          position: position,
          size: Vector2(cardWidth, cardHeight),
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);
  }
}

class ResourceCounterComponent extends PositionComponent {
  final Player player;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_RESOURCES_BACKGROUND,
  );

  ResourceCounterComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle((size / 2).toOffset(), size.x / 2, fillPaint);

    canvas.drawText(
      text: player.resources.floor().toString(),
      position: size / 2,
      size: size.x / 2,
      color: Palette.CONTROLS_RESOURCES_FOREGROUND,
    );
  }
}

class UnitSelectorComponent extends PositionComponent with DragCallbacks {
  final Player player;
  final UnitType unitType;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_CARD_BACKGROUND,
  );
  final Paint foregroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_CARD_FOREGROUND,
  );
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
  );
  Vector2 initialPosition = Vector2(0, 0);

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.controls.value);

  @override
  FutureOr onLoad() {
    add(RectangleHitbox(isSolid: true));

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    initialPosition.setFrom(position);
  }

  /*void _spawnUnitOfPlayer({
    required Lane lane,
    required Node? node,
    required Player player,
    required UnitType unitType,
  }) {
    engine.onSpawnUnit(
      lane: lane,
      player: player,
      node: node ?? lane.nodes.first,
      unitType: unitType,
    );
    player.spendResources(unitType.cost);
  }*/

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), fillPaint);

    double fillValue = 1 - (unitType.cost - player.resources);
    fillValue = fillValue.clamp(0, 1);
    final double height = size.y * fillValue;

    canvas.drawRect(
      Rect.fromLTWH(0, size.y - height, size.x, height),
      foregroundPaint,
    );

    final Color cardColor =
        fillValue == 1 ? player.color : Palette.CONTROLS_CARD_VALUE;

    borderPaint.color = cardColor;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), borderPaint);

    canvas.drawText(
      text: unitType.cost.toString(),
      position: size / 2,
      size: size.y / 2,
      color: cardColor,
    );
  }
}
