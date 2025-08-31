import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint backgroundPaint = Palette.paint(style: PaintingStyle.fill);

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(
         anchor: Anchor.topLeft,
         priority: Priority.controls.value,
       ) {
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
  final Player player;
  final UnitType unitType;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  bool enabled = false;

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
        size: size * 0.6,
      ),
    );

    add(
      UnitCostComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.81, size.y * 0.83),
        size: Vector2(size.x * 0.3, size.y * 0.34),
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final bool before = enabled;
    enabled = player.resources >= unitType.deploymentCost;

    if (before != enabled) {
      if (enabled) {
        decorator.removeLast();
      } else {
        decorator.addLast(PaintDecorator.tint(const Color(0x50000000)));
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), backgroundPaint);
  }
}

class UnitImageComponent extends SpriteComponent with DragCallbacks {
  final Player player;
  final UnitType unitType;
  Vector2 initialPosition = Vector2(0, 0);

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

  bool get enabled =>
      parent is UnitSelectorComponent &&
      (parent as UnitSelectorComponent).enabled;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (enabled) {
      initialPosition.setFrom(position);
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (enabled) {
      position += event.localDelta;

      match.highlightNodeAt(
        nodeTypes: [NodeType.launcher],
        position: absolutePosition,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    match.unhighlightNodes();

    if (enabled) {
      final LauncherComponent? launcherComponent = match.getLauncherAt(
        absolutePosition,
      );

      if (launcherComponent != null) {
        match.onDeployUnit(
          launcherComponent: launcherComponent,
          unitType: unitType,
        );
      }

      position = initialPosition;
    }
  }
}

class UnitCostComponent extends PositionComponent {
  final Player player;
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
  final Player player;

  ResourcesComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  void update(double dt) {
    super.update(dt);

    player.addResources(dt * Constants.RESOURCES_PER_SECOND);
  }

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
