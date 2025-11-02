import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/battlefield_component.dart';
import 'package:tensionpath/domain/components/movement_path_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/shot_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/alert_timer.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitComponent extends PositionComponent
    with DragCallbacks, HasVisibility {
  final String id;
  final UnitType type;
  final num nodeSizeRatio;
  final Player player;
  final AlertTimer attackAlert = AlertTimer(10);
  late HealthBarComponent healthBarComponent;
  late NodeComponent closestNodeComponent;
  final MovementPathComponent? movementOrderComponent;
  final MovementPathComponent? movementCurrentComponent;
  final BattlefieldComponent battlefieldComponent;
  List<Vector2> targetPositions;
  NodeComponent? lockedNode;
  NodeComponent? targetBase;
  UnitComponent? targetUnit;
  Vector2? endPosition;

  UnitComponent({
    required super.position,
    required super.size,
    required this.id,
    required this.type,
    required this.nodeSizeRatio,
    required this.player,
    required this.lockedNode,
    required this.movementOrderComponent,
    required this.movementCurrentComponent,
    required this.battlefieldComponent,
    required this.targetPositions,
    required this.targetBase,
    required this.targetUnit,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.unit.value,
       );

  bool get isAlive =>
      (healthBarComponent.health > 0) && !isRemoving && !isRemoved && isMounted;

  @override
  bool containsLocalPoint(Vector2 point) => Dimensions.pointInCircle(
    point: point,
    size: size,
  );

  bool belongsTo(Player other) => player.id == other.id;

  void onMovementStarted({
    required Vector2 newCurrentPosition,
    required List<Vector2> newTargetPositions,
  }) {
    position = newCurrentPosition;
    targetPositions = newTargetPositions;
  }

  void onMovementEnded({
    required Vector2 newCurrentPosition,
    required NodeComponent? newLockedNode,
  }) {
    position = newCurrentPosition;
    lockedNode = newLockedNode;
  }

  void onUnitAttack({
    required UnitComponent targetUnit,
    required num damage,
    required bool targetDestroyed,
  }) {
    final ShotToUnitComponent shotComponent = ShotToUnitComponent(
      position: Vector2.zero(),
      size: size / 30,
      attackerUnit: this,
      targetUnit: targetUnit,
      damage: damage,
      targetDestroyed: targetDestroyed,
    );
    match.add(shotComponent);
  }

  void onHit(num damage) {
    healthBarComponent.removeHealth(damage);
  }

  bool get isRevealed => closestNodeComponent.isRevealed;

  @override
  FutureOr onLoad() async {
    closestNodeComponent = match.getClosestNodeAt(absolutePosition);

    add(
      UnitImageComponent(
        position: size / 2,
        size: Vector2(size.x, size.x),
        unitType: type,
        player: player,
      ),
    );

    healthBarComponent = HealthBarComponent(
      position: size / 2,
      size: size,
      type: type,
      player: player,
    );

    add(healthBarComponent);

    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (player.isSelf) {
      final Vector2 offsetFromCenter = event.localPosition - (size / 2);

      endPosition = Vector2(
        absolutePosition.x + offsetFromCenter.x,
        absolutePosition.y + offsetFromCenter.y,
      );
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (player.isSelf) {
      endPosition = Vector2(
        endPosition!.x + event.localDelta.x,
        endPosition!.y + event.localDelta.y,
      );

      match.highlightActionNodeAt(
        position: endPosition!,
        unitType: type,
      );
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (player.isSelf && isAlive) {
      final UnitComponent? unitComponent = match.getEnemyUnitAt(endPosition!);

      if ((unitComponent != null) && (unitComponent.isRevealed)) {
        Audio.get.playSound(Sound.randomAttackSound());

        match.onUnitAction(
          unitComponent: this,
          targetNodeComponent: null,
          targetUnitComponent: unitComponent,
        );
      } else {
        final NodeComponent? nodeComponent = match.getActionNodeAt(
          position: endPosition!,
          unitType: type,
        );

        final bool standingToMoving =
            (targetPositions.isEmpty) &&
            (nodeComponent != closestNodeComponent);
        final bool movingToMoving = targetPositions.isNotEmpty;

        if ((nodeComponent != null) && (standingToMoving || movingToMoving)) {
          Audio.get.playSound(Sound.randomMovementSound());

          match.onUnitAction(
            unitComponent: this,
            targetNodeComponent: nodeComponent,
            targetUnitComponent: null,
          );
        }
      }
    }

    endPosition = null;
    movementOrderComponent?.hide();
    match.unhighlightNodes();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (match.match.isPlaying) {
      attackAlert.update(dt);

      if (targetPositions.isNotEmpty) {
        final Vector2 targetPosition = targetPositions.first;

        if (player.isSelf) {
          movementCurrentComponent?.show(
            [
              absolutePosition,
              for (final Vector2 position in targetPositions)
                position + battlefieldComponent.position,
            ],
          );
        }

        final num speed = nodeSizeRatio * type.speed.value;
        final double distance = speed * dt;
        final (Vector2, bool) movement = _moveTowards(
          origin: position,
          target: targetPosition,
          distance: distance,
        );
        position = movement.$1;

        if (movement.$2) {
          targetPositions.removeAt(0);
        }
      } else {
        movementCurrentComponent?.hide();
      }

      closestNodeComponent = match.getClosestNodeAt(absolutePosition);

      isVisible = closestNodeComponent.isRevealed || player.isSelf;
    }
  }

  (Vector2, bool) _moveTowards({
    required Vector2 origin,
    required Vector2 target,
    required double distance,
  }) {
    final Vector2 direction = target - origin;

    if (distance < direction.length) {
      direction.normalize();

      return (origin + (direction * distance), false);
    } else {
      return (target, true);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (endPosition != null) {
      movementOrderComponent?.show([absolutePosition, endPosition!]);
    }
  }

  void destroy() {
    lockedNode?.unlock();
    movementOrderComponent?.removeFromParent();
    movementCurrentComponent?.removeFromParent();
    removeFromParent();
  }
}

class UnitImageComponent extends SpriteComponent {
  final UnitType unitType;
  final Player player;

  UnitImageComponent({
    required super.position,
    required super.size,
    required this.unitType,
    required this.player,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(
      matchUnitSprite(
        type: unitType,
        player: player,
      ),
    );
    scale = battlefieldUnitScale(unitType);

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

class HealthBarComponent extends PositionComponent with HasVisibility {
  final UnitType type;
  final Player player;
  final Paint foregroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_HEALTH_BACKGROUND,
  );
  final Paint borderHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_HEALTH_BORDER,
  );
  late num health;
  late num maxHealth;
  late Rect rect;

  HealthBarComponent({
    required super.position,
    required super.size,
    required this.type,
    required this.player,
  }) : super(anchor: Anchor.center) {
    foregroundHealthPaint.color = player.color;
    borderHealthPaint.strokeWidth = size.y / 100;
    health = type.health.toDouble();
    maxHealth = type.health.toDouble();

    final double rectWidth = size.x * 0.7;
    final double rectHeight = size.y * 0.06;
    final double rectX = (size.x - rectWidth) / 2;
    final double rectY = size.y * 0.18;
    rect = Rect.fromLTWH(rectX, rectY, rectWidth, rectHeight);
  }

  void removeHealth(num damage) {
    health -= damage;

    if (health < 0) {
      health = 0;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    isVisible = (health < maxHealth) && (health > 0);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(rect, backgroundHealthPaint);

    final Rect rectHealth = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width * (health / maxHealth),
      rect.height,
    );
    canvas.drawRect(rectHealth, foregroundHealthPaint);

    canvas.drawRect(rect, borderHealthPaint);
  }
}
