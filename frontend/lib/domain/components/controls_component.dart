import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
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
      PopcapComponent(
        player: player,
        position: Dimensions.controlsPopcapPosition(
          size: size,
          cardSize: cardSize,
          numberOfCards: numberOfCards,
        ),
        size: Dimensions.controlsPopcapSize(size),
      ),
    );

    add(
      ResourceComponent(
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

class UnitImageComponent extends SpriteComponent
    with DragCallbacks
    implements Reconfigurable {
  final Player player;
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
  void reconfigure() {
    isEnabled = match.match.canDeployUnit(unitType);
  }

  @override
  FutureOr onLoad() async {
    reconfigure();

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
        match.match.onDeployUnit(node: nodeComponent.node, unitType: unitType);
      }

      position = initialPosition;
      dragging = false;
    }
  }
}

class UnitCostComponent extends PositionComponent implements Reconfigurable {
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
  void reconfigure() {
    isEnabled = match.match.canDeployUnit(unitType);
  }

  @override
  FutureOr onLoad() {
    reconfigure();

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

class PopcapComponent extends PositionComponent implements Reconfigurable {
  final Player player;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_POPCAP_BACKGROUND,
  );
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint placeholderPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_PLACEHOLDER,
  );
  int population = 0;

  PopcapComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft) {
    foregroundPaint.color = player.color;
  }

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    population = 0;

    /*for (final Node node in match.match.battlefield.nodes) {
      if (node.hasUnit && node.unit!.belongsTo(player)) {
        population++;
      }
    }*/
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), backgroundPaint);

    final double gap = size.x / 80;
    const int popcap = Constants.POPCAP_LIMIT;
    final double blockSize = (width - gap * (popcap + 1)) / popcap;

    for (int i = 0; i < population; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        foregroundPaint,
      );
    }

    for (int i = population; i < popcap; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        placeholderPaint,
      );
    }
  }
}

class ResourceComponent extends PositionComponent {
  final Player player;

  ResourceComponent({
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
