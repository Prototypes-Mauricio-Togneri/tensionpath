import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final JsonPlayer player;
  final Paint backgroundPaint = Palette.paint(style: PaintingStyle.fill);

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value) {
    backgroundPaint.color = player.color.darken(0.2);
  }

  @override
  FutureOr onLoad() {
    final int numberOfUnits = UnitType.values.length;
    final int numberOfCards = numberOfUnits + 2;
    final Vector2 cardSize = Dimensions.controlsCardSize(
      size: size,
      numberOfCards: numberOfCards,
    );

    for (int i = 0; i < numberOfUnits; i++) {
      add(
        UnitSelectorComponent(
          player: player,
          unitType: UnitType.values[i],
          position: Dimensions.controlsUnitCardPosition(
            size: size,
            cardSize: cardSize,
            i: i,
          ),
          size: cardSize,
        ),
      );
    }

    add(
      ResourcesComponent(
        player: player,
        position: Dimensions.controlsResourcesCardPosition(
          size: size,
          cardSize: cardSize,
          numberOfCards: numberOfCards,
        ),
        size: cardSize,
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);
  }
}

class UnitSelectorComponent extends PositionComponent {
  final JsonPlayer player;
  final UnitType unitType;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
  );

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    backgroundPaint.color = player.color.darken(0.3);

    add(
      UnitImageComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x / 2, size.y / 2),
        size: size * 0.7,
      ),
    );

    add(
      UnitCostComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.85, size.y * 0.83),
        size: Vector2(size.x * 0.3, size.y * 0.34),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), backgroundPaint);
  }
}

class UnitImageComponent extends SpriteComponent with DragCallbacks {
  final JsonPlayer player;
  final UnitType unitType;
  bool isEnabled = false;
  Vector2 initialPosition = Vector2(0, 0);
  bool dragging = false;

  UnitImageComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(unitType.thumbnail);
    decorator.addLast(PaintDecorator.tint(player.color));

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
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (isEnabled) {
      /*final NodeComponent? nodeComponent = match.getLauncherAt(
        absolutePosition,
      );

      if (nodeComponent != null) {
        match.match.onDeployUnit(node: nodeComponent.node, unitType: unitType);
      }*/

      position = initialPosition;
      dragging = false;
    }
  }
}

class UnitCostComponent extends PositionComponent {
  final JsonPlayer player;
  final UnitType unitType;
  bool isEnabled = false;

  UnitCostComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${unitType.deploymentCost.toString()}🛢️',
      position: Vector2(size.x * 1, size.y * 0.55),
      size: size.x / 2.5,
      color: Palette.CONTROLS_COST_FOREGROUND,
      anchor: Anchor.centerRight,
    );
  }
}

class ResourcesComponent extends PositionComponent {
  final JsonPlayer player;

  ResourcesComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${player.resources.floor().toString()}🛢️',
      position: Vector2(size.x * 0.5, size.y * 0.2),
      size: size.x / 5,
      color: Palette.CONTROLS_COST_FOREGROUND,
    );
  }
}
