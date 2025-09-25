import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/extensions/sprite_component_extension.dart';
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
    final int numberOfCards = numberOfUnits + 1;
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
  bool isEnabled = false;

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    backgroundPaint.color = player.color.darken(0.3);

    final double spriteSize = min(size.x, size.y);

    add(
      UnitImageComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.35, size.y * 0.5),
        size: Vector2(spriteSize, spriteSize) * 0.8,
      ),
    );

    add(
      UnitCostComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.81, size.y * 0.75),
        size: Vector2(size.x * 0.3, size.y * 0.34),
      ),
    );

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    final bool before = isEnabled;
    isEnabled = player.resources >= unitType.cost;

    if (before != isEnabled) {
      if (isEnabled) {
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
    sprite = await Sprite.load(unitSprite(unitType));

    if (player.isPlayer1) {
      setBlueShade();
    } else if (player.isPlayer2) {
      setRedShade();
    }

    return super.onLoad();
  }

  bool get enabled =>
      parent is UnitSelectorComponent &&
      (parent as UnitSelectorComponent).isEnabled;

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

      match.highlightLauncherAt(
        position: absolutePosition,
        player: player,
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

      if ((launcherComponent != null) &&
          (launcherComponent.player == player) &&
          (launcherComponent.nodeComponent.isFree)) {
        match.onDeployUnit(
          location: launcherComponent.nodeComponent.location,
          type: unitType,
        );
      }

      position = initialPosition;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.save();

    if (player.isPlayer2) {
      canvas.translate(size.x / 2, 0); // Move to the center of the sprite
      canvas.scale(-1, 1); // Flip horizontally
      canvas.translate(-size.x / 2, 0); // Move back to the original position
    }

    super.render(canvas);

    canvas.restore();
  }
}

class UnitCostComponent extends PositionComponent {
  final Player player;
  final UnitType unitType;

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
      text: '${unitType.cost.toString()}${Constants.RESOURCE_ICON}',
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

    player.addResources(dt * player.resourcesRate);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${player.resources.floor()}${Constants.RESOURCE_ICON}',
      position: Vector2(size.x * 0.5, size.y * 0.2),
      size: size.x / 5,
      color: Palette.CONTROLS_COST_FOREGROUND,
    );

    canvas.drawText(
      text: '${player.resourcesRate}/s',
      position: Vector2(size.x * 0.5, size.y * 0.7),
      size: size.x / 10,
      color: Palette.CONTROLS_COST_FOREGROUND,
    );
  }
}
