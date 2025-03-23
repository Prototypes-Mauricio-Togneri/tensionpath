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

    for (int i = 0; i < 6; i++) {
      final Vector2 position = Vector2(
        (i * cardWidth) + ((i + 1) * horizontalGapSize),
        verticalGapSize,
      );

      add(
        UnitSelectorComponent(
          player: player,
          unitType: UnitType.values[i],
          position: position,
          size: Vector2(cardWidth, cardHeight),
        ),
      );
    }

    add(
      ResourceCounterComponent(
        player: player,
        position: Vector2(
          (6 * cardWidth) + (horizontalGapSize * 7),
          verticalGapSize,
        ),
        size: Vector2(cardWidth, (cardHeight / 2) - (verticalGapSize / 2)),
      ),
    );

    add(
      PassTurnComponent(
        player: player,
        position: Vector2(
          (6 * cardWidth) + (horizontalGapSize * 7),
          (cardHeight / 2) + verticalGapSize * 1.5,
        ),
        size: Vector2(cardWidth, (cardHeight / 2) - (verticalGapSize / 2)),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fillPaint);
  }
}

class UnitSelectorComponent extends PositionComponent with DragCallbacks {
  final Player player;
  final UnitType unitType;
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);
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
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value) {
    borderPaint.color = player.color;
    fillPaint.color = player.color.brighten(0.5);
  }

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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), fillPaint);
    canvas.drawRect(size.toRect(), borderPaint);

    canvas.drawText(
      text: unitType.name,
      position: size / 2,
      size: size.y / 8,
      color: borderPaint.color,
    );
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

    canvas.drawRect(size.toRect(), fillPaint);

    canvas.drawText(
      text: player.resources.floor().toString(),
      position: size / 2,
      size: size.x / 3,
      color: Palette.CONTROLS_RESOURCES_FOREGROUND,
    );
  }
}

class PassTurnComponent extends PositionComponent {
  final Player player;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_RESOURCES_BACKGROUND,
  );

  PassTurnComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), fillPaint);

    canvas.drawText(
      text: 'PASS',
      position: size / 2,
      size: size.x / 4,
      color: Palette.CONTROLS_RESOURCES_FOREGROUND,
    );
  }
}
