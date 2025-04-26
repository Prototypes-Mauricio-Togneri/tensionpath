import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/environments/environment.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/extensions/paint_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class ControlsComponent extends PositionComponent {
  final Player player;
  final Paint fillPaint = Palette.paint(style: PaintingStyle.fill);

  ControlsComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.controls.value) {
    fillPaint.color = player.color.darken(0.2);
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
      ResourceCounterComponent(
        player: player,
        position: Dimensions.controlsResourcesCardPosition(
          size: size,
          cardSize: cardSize,
          numberOfCards: numberOfCards,
        ),
        size: cardSize,
      ),
    );

    add(
      EndTurnComponent(
        player: player,
        position: Dimensions.controlsEndTurnCardPosition(
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

    final Paint fill =
        match.match.isSelfTurn
            ? fillPaint
            : fillPaint.clone(color: Palette.CONTROLS_BACKGROUND_DISABLED);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fill);
  }
}

class UnitSelectorComponent extends PositionComponent with DragCallbacks {
  final Player player;
  final UnitType unitType;
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 5,
  );
  Vector2 initialPosition = Vector2(0, 0);
  bool dragging = false;
  bool isEnabled = false;

  UnitSelectorComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center) {
    borderPaint.color = player.color.darken(0.5);
  }

  void reconfigure() {
    isEnabled = match.match.canDeployUnit(unitType);
  }

  @override
  FutureOr onLoad() {
    reconfigure();

    add(
      UnitImageComponent(
        player: player,
        unitType: unitType,
        position: Vector2(size.x / 2, size.y / 2),
        size: size,
      ),
    );

    add(
      UnitDamageComponent(
        player: player,
        unitType: unitType,
        unitClass: UnitClass.infantry,
        position: Vector2(size.x * 0.07, size.y * 0.85),
        size: Vector2(size.x * 0.15, size.x * 0.15),
      ),
    );

    add(
      UnitDamageComponent(
        player: player,
        unitType: unitType,
        unitClass: UnitClass.vehicle,
        position: Vector2(size.x * 0.22, size.y * 0.85),
        size: Vector2(size.x * 0.15, size.x * 0.15),
      ),
    );

    add(
      UnitDamageComponent(
        player: player,
        unitType: unitType,
        unitClass: UnitClass.aircraft,
        position: Vector2(size.x * 0.37, size.y * 0.85),
        size: Vector2(size.x * 0.15, size.x * 0.15),
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

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint border =
        isEnabled
            ? borderPaint
            : borderPaint.clone(color: Palette.CONTROLS_FILL_DISABLED);

    if (dragging) {
      border.color = border.color.withAlpha(100);
    } else {
      border.color = border.color.withAlpha(255);
    }

    canvas.drawRect(size.toRect(), border);
  }
}

class UnitImageComponent extends SpriteComponent {
  final Player player;
  final UnitType unitType;
  PaintDecorator? grayscale;
  bool isEnabled = false;

  UnitImageComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  void reconfigure() {
    isEnabled = match.match.canDeployUnit(unitType);
  }

  @override
  FutureOr onLoad() async {
    reconfigure();

    sprite = await Sprite.load(unitType.thumbnail);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isEnabled) {
      if (grayscale != null) {
        decorator.removeLast();
        grayscale = null;
      }
    } else {
      if (grayscale == null) {
        grayscale = PaintDecorator.grayscale(opacity: 0.5);
        decorator.addLast(grayscale);
      }
    }

    final UnitSelectorComponent unitSelector = parent as UnitSelectorComponent;

    if (unitSelector.dragging) {
      paint.color = paint.color.withAlpha(128);
    } else {
      paint.color = paint.color.withAlpha(255);
    }
  }
}

class UnitCostComponent extends PositionComponent {
  final Player player;
  final UnitType unitType;
  final Paint textPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.CONTROLS_COST_FOREGROUND,
  );
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_COST_BACKGROUND,
  );
  bool isEnabled = false;

  UnitCostComponent({
    required this.player,
    required this.unitType,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

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

    canvas.drawRect(size.toRect(), backgroundPaint);

    final UnitSelectorComponent unitSelector = parent as UnitSelectorComponent;

    final Paint text =
        isEnabled
            ? textPaint
            : textPaint.clone(color: Palette.CONTROLS_FILL_DISABLED);

    if (!unitSelector.dragging && isEnabled) {
      text.color = text.color.withAlpha(255);
    } else {
      text.color = text.color.withAlpha(128);
    }

    canvas.drawText(
      text: '${unitType.deploymentCost.toString()}🛢️',
      position: Vector2(size.x * 1, size.y * 0.55),
      size: size.x / 3.5,
      color: text.color,
      anchor: Anchor.centerRight,
    );
  }
}

class UnitDamageComponent extends SpriteComponent {
  final Player player;
  final UnitType unitType;
  final UnitClass unitClass;
  PaintDecorator? grayscale;
  bool isEnabled = false;

  UnitDamageComponent({
    required this.player,
    required this.unitType,
    required this.unitClass,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  void reconfigure() {
    isEnabled = match.match.canDeployUnit(unitType);
  }

  @override
  FutureOr onLoad() async {
    reconfigure();
    final int damage = unitType.damageAgainst(unitClass);

    if (damage == 0) {
      sprite = await Sprite.load('counter/${unitClass.name}_normal.png');
    } else if (damage == 1) {
      sprite = await Sprite.load('counter/${unitClass.name}_good.png');
    } else if (damage == -1) {
      sprite = await Sprite.load('counter/${unitClass.name}_bad.png');
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isEnabled) {
      if (grayscale != null) {
        decorator.removeLast();
        grayscale = null;
      }
    } else {
      if (grayscale == null) {
        grayscale = PaintDecorator.grayscale(opacity: 0.5);
        decorator.addLast(grayscale);
      }
    }

    final UnitSelectorComponent unitSelector = parent as UnitSelectorComponent;

    if (unitSelector.dragging) {
      paint.color = paint.color.withAlpha(128);
    } else {
      paint.color = paint.color.withAlpha(255);
    }
  }
}

class PopcapComponent extends PositionComponent {
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

  void reconfigure() {
    population = 0;

    for (final Node node in match.match.battlefield.nodes) {
      if (node.hasUnit && node.unit!.belongsTo(player)) {
        population++;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint fill =
        match.match.isSelfTurn
            ? backgroundPaint
            : backgroundPaint.clone(color: Palette.CONTROLS_FILL_DISABLED);

    canvas.drawRect(size.toRect(), fill);

    final double gap = size.x / 80;
    final double blockSize =
        (width - gap * (Constants.MAX_POP_CAP + 1)) / Constants.MAX_POP_CAP;

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

    for (int i = population; i < Constants.MAX_POP_CAP; i++) {
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
  }) : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint fill =
        match.match.isSelfTurn
            ? fillPaint
            : fillPaint.clone(color: Palette.CONTROLS_FILL_DISABLED);

    canvas.drawRect(size.toRect(), fill);

    canvas.drawText(
      text: '${player.resources.floor().toString()}🛢️',
      position: Vector2(size.x * 0.55, size.y * 0.5),
      size: size.x / 4,
      color: Palette.CONTROLS_RESOURCES_FOREGROUND,
    );
  }
}

class EndTurnComponent extends PositionComponent with TapCallbacks {
  final Player player;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.CONTROLS_END_TURN_BACKGROUND,
  );

  @override
  void onTapUp(TapUpEvent event) {
    if (match.match.isSelfTurn) {
      match.match.onEndTurn();
    } else if (Environment.get.isDebug) {
      match.match.onOpponentEndTurn();
    }
  }

  EndTurnComponent({
    required this.player,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final Paint fill =
        match.match.isSelfTurn
            ? fillPaint
            : fillPaint.clone(color: Palette.CONTROLS_FILL_DISABLED);

    canvas.drawRect(size.toRect(), fill);

    if (match.match.isSelfTurn) {
      canvas.drawText(
        text: '${match.match.accumulatedResourcesInTurn.floor()}🛢️',
        position: Vector2(size.x / 2, size.y / 3.5),
        size: size.x / 6,
        color: Palette.CONTROLS_RESOURCES_FOREGROUND,
      );

      canvas.drawText(
        text: 'END TURN',
        position: Vector2(size.x / 2, size.y * 3 / 4),
        size: size.x / 7,
        color: Palette.CONTROLS_RESOURCES_FOREGROUND,
      );
    } else {
      canvas.drawText(
        text: "WAITING FOR\nOPPONENT'S\nTURN",
        position: Vector2(size.x / 2, size.y / 2),
        size: size.x / 8,
        color: Palette.CONTROLS_RESOURCES_FOREGROUND,
      );
    }
  }
}
