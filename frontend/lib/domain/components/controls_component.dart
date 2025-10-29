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
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final int maxHarvestersCount;
  final Paint backgroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Map<BuildingType, BuildingComponent> buildingComponents = {};

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

    int previousCards = player.deck.contains(UnitType.harvester) ? 1 : 0;

    for (final BuildingType buildingType in BuildingType.buildings) {
      final int numberOfUnits = player.unitsInBuilding(buildingType);

      if (numberOfUnits > 0) {
        final BuildingComponent buildingComponent = BuildingComponent(
          player: player,
          buildingType: buildingType,
          position: Dimensions.controlsBuildingCardPosition(
            size: size,
            cardSize: cardSize,
            previousCards: previousCards,
          ),
          size: Dimensions.controlsBuildingCardSize(
            size: size,
            cardSize: cardSize,
            cards: numberOfUnits,
          ),
        );

        add(buildingComponent);
        buildingComponents[buildingType] = buildingComponent;

        previousCards += numberOfUnits;
      }
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

  void unlockBuilding(BuildingType buildingType) {
    final BuildingComponent? buildingComponent =
        buildingComponents[buildingType];

    if (buildingComponent != null) {
      buildingComponent.removeFromParent();
      buildingComponents.remove(buildingType);
      Audio.get.playSound(Sound.EVA_BUILDING_ONLINE);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);
  }
}

class BuildingComponent extends PositionComponent with TapCallbacks {
  final Player player;
  final BuildingType buildingType;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
  );
  bool isEnabled = false;

  BuildingComponent({
    required this.player,
    required this.buildingType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  FutureOr onLoad() {
    backgroundPaint.color = player.color.darken(0.3);
    borderPaint.color = player.color.darken(0.5);
    borderPaint.strokeWidth = size.x / 30;

    final Vector2 spriteSize = size / 2;
    final double minSize = min(spriteSize.x, spriteSize.y);

    add(
      BuildingImageComponent(
        buildingType: buildingType,
        position: size / 2,
        size: Vector2(minSize, minSize),
      ),
    );

    final double bottomPartSize = size.x / 6;

    add(
      BuildingCostComponent(
        buildingType: buildingType,
        position: Vector2(
          size.x - (bottomPartSize * 1.7),
          size.y - (bottomPartSize * 1.2),
        ),
        size: Vector2(bottomPartSize * 1.5, bottomPartSize),
      ),
    );

    return super.onLoad();
  }

  @override
  bool onTapDown(TapDownEvent event) {
    game.matchState.onUnlockBuilding(buildingType);
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final bool before = isEnabled;
    isEnabled = player.resources >= buildingType.cost;

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
    canvas.drawRect(size.toRect(), borderPaint);
  }
}

class BuildingImageComponent extends SpriteComponent {
  final BuildingType buildingType;

  BuildingImageComponent({
    required this.buildingType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    if (buildingType == BuildingType.barracks) {
      sprite = await Sprite.load(Assets.IMAGES_UNITS_COUNTER_INFANTRY_NORMAL);
    } else if (buildingType == BuildingType.factory) {
      sprite = await Sprite.load(Assets.IMAGES_UNITS_COUNTER_VEHICLE_NORMAL);
    } else if (buildingType == BuildingType.airfield) {
      sprite = await Sprite.load(Assets.IMAGES_UNITS_COUNTER_AIRCRAFT_NORMAL);
    }

    return super.onLoad();
  }
}

class BuildingCostComponent extends PositionComponent {
  final BuildingType buildingType;

  BuildingCostComponent({
    required this.buildingType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${buildingType.cost}${Constants.RESOURCE_ICON}',
      position: Vector2(size.x * 0.9, size.y * 0.5),
      size: size.x / 2.5,
      color: Palette.CONTROLS_COST_FOREGROUND,
      anchor: Anchor.centerRight,
    );
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
        position: Vector2(size.x * 0.5, size.y * 0.4),
        size: Vector2(spriteSize, spriteSize) * controlsUnitScale(unitType),
      ),
    );

    add(
      UnitDraggableComponent(
        player: player,
        unitType: unitType,
        unitSelectorComponent: this,
        position: Vector2(size.x * 0.5, size.y * 0.4),
        size: size,
      ),
    );

    final double bottomPartSize = size.x / 6;

    add(
      UnitCounterComponent(
        unitType: unitType,
        position: Vector2(0, size.y - bottomPartSize),
        size: Vector2(bottomPartSize * 3, bottomPartSize),
      ),
    );

    add(
      UnitCostComponent(
        player: player,
        unitType: unitType,
        position: Vector2(
          size.x - (bottomPartSize * 1.5),
          size.y - bottomPartSize,
        ),
        size: Vector2(bottomPartSize * 1.5, bottomPartSize),
      ),
    );

    return super.onLoad();
  }

  int get unitCost {
    if (unitType == UnitType.harvester) {
      if (player.currentHarvesterCount < player.maxHarvestersCount) {
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

  bool get underPopcap => match.unitsOfPlayer(player) < match.match.popcap;

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
  }) : super(anchor: Anchor.topLeft);

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
      position: Vector2(size.x * 0.9, size.y * 0.5),
      size: size.x / 2.5,
      color: Palette.CONTROLS_COST_FOREGROUND,
      anchor: Anchor.centerRight,
    );
  }
}

class UnitCounterComponent extends PositionComponent {
  final UnitType unitType;

  UnitCounterComponent({
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  FutureOr onLoad() async {
    add(
      UnitCounterIconComponent(
        iconPath:
            'units/counter/infantry_${unitType.counterAgainst(UnitClass.infantry)}.png',
        position: Vector2(0, 0),
        size: Vector2(size.x / 3, size.y),
      ),
    );

    add(
      UnitCounterIconComponent(
        iconPath:
            'units/counter/vehicle_${unitType.counterAgainst(UnitClass.vehicle)}.png',
        position: Vector2(size.x / 3, 0),
        size: Vector2(size.x / 3, size.y),
      ),
    );

    add(
      UnitCounterIconComponent(
        iconPath:
            'units/counter/aircraft_${unitType.counterAgainst(UnitClass.aircraft)}.png',
        position: Vector2(size.x * 2 / 3, 0),
        size: Vector2(size.x / 3, size.y),
      ),
    );

    return super.onLoad();
  }
}

class UnitCounterIconComponent extends SpriteComponent {
  final String iconPath;

  UnitCounterIconComponent({
    required this.iconPath,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(iconPath);

    return super.onLoad();
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

    if (match.match.isPlaying) {
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

    if (Environment.get.isLocal) {
      canvas.drawText(
        text:
            '${player.resourcesRate}${Constants.RESOURCE_ICON} / s  -  ${match.match.popcap}',
        position: Vector2(size.x * 0.5, size.y * 0.7),
        size: size.x / 10,
        color: Palette.CONTROLS_COST_FOREGROUND,
      );
    }
  }
}
