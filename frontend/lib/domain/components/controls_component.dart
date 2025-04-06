import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/extensions/paint_extension.dart';
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
    final double gapSize = size.x * 0.1;
    final double cardWidth = size.x - (gapSize * 2);
    final double cardHeight = (size.y - (gapSize * 9)) / 8;

    for (int i = 0; i < 6; i++) {
      final Vector2 position = Vector2(
        gapSize + (cardWidth / 2),
        ((i + 0.5) * cardHeight) + ((i + 1) * gapSize),
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
        position: Vector2(gapSize, (6 * cardHeight) + (gapSize * 7)),
        size: Vector2(cardWidth, cardHeight),
      ),
    );

    add(
      PassTurnComponent(
        player: player,
        position: Vector2(gapSize, (7 * cardHeight) + (gapSize * 8)),
        size: Vector2(cardWidth, cardHeight),
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
  bool dragging = false;

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.controls.value) {
    borderPaint.color = player.color;
    fillPaint.color = player.color.brighten(0.5);
  }

  bool get isEnabled => player.resources >= unitType.cost;

  @override
  FutureOr onLoad() {
    add(RectangleHitbox(isSolid: true));

    final double unitImageSize = min(size.x * 0.8, size.y * 0.8);
    add(
      UnitImageComponent(
        type: unitType,
        position: Vector2(size.x / 2, size.y / 2),
        size: Vector2(unitImageSize, unitImageSize),
      ),
    );

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (isEnabled) {
      initialPosition.setFrom(position);
      dragging = true;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (isEnabled) {
      position += event.localDelta;
      match.highlightNode(match.getLauncherAt(absolutePosition));
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (isEnabled) {
      final NodeComponent? nodeComponent = match.getLauncherAt(
        absolutePosition,
      );

      if (nodeComponent != null) {
        match.onDeployUnit(nodeComponent: nodeComponent, unitType: unitType);
      }

      position = initialPosition;
      dragging = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint border =
        isEnabled
            ? borderPaint
            : borderPaint.clone(color: Palette.CONTROLS_UNIT_BORDER_DISABLED);
    final Paint fill =
        isEnabled
            ? fillPaint
            : fillPaint.clone(color: Palette.CONTROLS_UNIT_FILL_DISABLED);

    if (dragging) {
      border.color = border.color.withAlpha(100);
      fill.color = fill.color.withAlpha(100);
    } else {
      border.color = border.color.withAlpha(255);
      fill.color = fill.color.withAlpha(255);
    }

    canvas.drawRect(size.toRect(), fill);
    canvas.drawRect(size.toRect(), border);

    canvas.drawText(
      text: unitType.cost.toString(),
      position: Vector2(size.x * 0.9, size.y * 0.8),
      size: size.y / 5,
      color: border.color,
    );
  }
}

class UnitImageComponent extends SpriteComponent {
  final UnitType type;

  UnitImageComponent({
    required this.type,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.controls.value);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(type.sprite);

    return super.onLoad();
  }
}

class ResourceCounterComponent extends PositionComponent with TapCallbacks {
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
  void onTapUp(TapUpEvent event) => match.onPassTurn();

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

class PassTurnComponent extends PositionComponent with TapCallbacks {
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
