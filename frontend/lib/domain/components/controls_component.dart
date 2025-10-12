import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final int maxHarvestersCount;
  final Paint backgroundPaint = Palette.paint(style: PaintingStyle.fill);

  ControlsComponent({
    required this.player,
    required this.maxHarvestersCount,
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
    final int numberOfUnits = player.deck.length;
    final int numberOfCards = numberOfUnits + 1;
    final Vector2 cardSize = Dimensions.controlsCardSize(
      size: size,
      numberOfCards: numberOfCards,
    );

    for (int i = 0; i < numberOfUnits; i++) {
      add(
        UnitSelectorComponent(
          player: player,
          unitType: player.deck[i],
          maxHarvestersCount: maxHarvestersCount,
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
  final int maxHarvestersCount;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  bool isEnabled = false;

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required this.maxHarvestersCount,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    backgroundPaint.color = player.color.darken(0.3);

    final double spriteSize = min(size.x, size.y);

    add(
      UnitImageComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.5, size.y * 0.5),
        size: Vector2(spriteSize, spriteSize) * controlsUnitScale(unitType),
      ),
    );

    add(
      UnitDraggableComponent(
        player: player,
        unitType: unitType,
        unitSelectorComponent: this,
        position: Vector2(size.x * 0.5, size.y * 0.5),
        size: size,
      ),
    );

    add(
      UnitCostComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.87, size.y * 0.82),
        size: Vector2(size.x * 0.2, size.y * 0.25),
      ),
    );

    return super.onLoad();
  }

  int get unitCost {
    if (unitType == UnitType.harvester) {
      if (player.currentHarvesterCount < player.maxHarvesterCount) {
        return 0;
      } else {
        return unitType.cost;
      }
    } else {
      return unitType.cost;
    }
  }

  bool get canDeploy {
    if (unitType == UnitType.harvester) {
      return player.currentHarvesterCount < maxHarvestersCount;
    } else {
      return true;
    }
  }

  int get popcapLimit {
    final int timeElapsed = match.timeElapsed;

    if (timeElapsed < 60) {
      return 3;
    } else if (timeElapsed < 120) {
      return 4;
    } else if (timeElapsed < 180) {
      return 5;
    } else {
      return 6;
    }
  }

  bool get underPopcap => match.unitsOfPlayer(player) < popcapLimit;

  @override
  void update(double dt) {
    super.update(dt);

    final bool before = isEnabled;
    isEnabled = (player.resources >= unitCost) && canDeploy && underPopcap;

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

class UnitDraggableComponent extends PositionComponent with DragCallbacks {
  final Player player;
  final UnitType unitType;
  final UnitSelectorComponent unitSelectorComponent;
  Vector2 initialPosition = Vector2(0, 0);

  UnitDraggableComponent({
    required this.player,
    required this.unitType,
    required this.unitSelectorComponent,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  bool get enabled => unitSelectorComponent.isEnabled;

  @override
  FutureOr onLoad() async {
    final double spriteSize = min(size.x, size.y);

    add(
      UnitImageComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x * 0.5, size.y * 0.5),
        size: Vector2(spriteSize, spriteSize) * controlsUnitScale(unitType),
      ),
    );

    return super.onLoad();
  }

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
      match.highlightActionNodeAt(
        position: absolutePosition,
        unitType: unitType,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    match.unhighlightNodes();

    if (enabled) {
      final NodeComponent? nodeComponent = match.getActionNodeAt(
        position: absolutePosition,
        unitType: unitType,
      );

      if (nodeComponent != null) {
        match.onDeployUnit(
          location: nodeComponent.location,
          type: unitType,
        );
      }

      position = initialPosition;
    }
  }
}

class UnitImageComponent extends SpriteComponent {
  final Player player;
  final UnitType unitType;

  UnitImageComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(
      matchUnitSprite(
        type: unitType,
        player: player,
      ),
    );

    return super.onLoad();
  }

  /*@override
  void render(Canvas canvas) {
    canvas.save();

    if (player.isPlayer2) {
      canvas.translate(size.x / 2, 0); // Move to the center of the sprite
      canvas.scale(-1, 1); // Flip horizontally
      canvas.translate(-size.x / 2, 0); // Move back to the original position
    }

    super.render(canvas);

    canvas.restore();
  }*/
}

class UnitCostComponent extends PositionComponent {
  final Player player;
  final UnitType unitType;
  late final UnitSelectorComponent unitSelectorComponent;

  UnitCostComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() {
    unitSelectorComponent = parent as UnitSelectorComponent;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final String cost = unitSelectorComponent.unitCost == 0
        ? 'FREE'
        : unitSelectorComponent.unitCost.toString();

    canvas.drawText(
      text: '$cost${Constants.RESOURCE_ICON}',
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

    if (game.matchState.matchStatus == MatchStatus.playing) {
      player.addResources(dt * player.resourcesRate);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${player.resources.floor()}${Constants.RESOURCE_ICON}',
      position: Vector2(size.x * 0.5, size.y * 0.4),
      size: size.x / 5,
      color: Palette.CONTROLS_COST_FOREGROUND,
    );

    /*canvas.drawText(
      text: '${player.resourcesRate}${Constants.RESOURCE_ICON} / s',
      position: Vector2(size.x * 0.5, size.y * 0.7),
      size: size.x / 10,
      color: Palette.CONTROLS_COST_FOREGROUND,
    );*/
  }
}
