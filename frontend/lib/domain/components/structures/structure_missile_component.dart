import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/palette.dart';

class StructureMissileComponent extends StructureComponent<StructureMissile> {
  late final Missile missile;

  StructureMissileComponent({
    required super.structure,
    required super.position,
    required super.size,
  }) {
    missile = match.match.battlefield.missile;
  }

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_MISSILE);

    add(
      MissileIndicatorComponent(
        missile: missile,
        position: size / 2,
        size: Vector2(size.x * 0.7, size.y * 0.1),
      ),
    );

    return super.onLoad();
  }
}

class MissileIndicatorComponent extends PositionComponent {
  final Missile missile;
  final Paint backgroundHealthPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.UNIT_HEALTH_BACKGROUND,
  );
  final Paint foregroundHealthPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderHealthPaint = Palette.paint(
    style: PaintingStyle.stroke,
    color: Palette.UNIT_HEALTH_BORDER,
  );

  MissileIndicatorComponent({
    required this.missile,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center) {
    borderHealthPaint.strokeWidth = size.y / 20;
  }

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  void reconfigure() {
    final String? owner = missile.owner;

    if (owner == null) {
      foregroundHealthPaint.color = Palette.MISSILE_OWNER_NONE;
    } else if (owner == '') {
      foregroundHealthPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (owner == Constants.PLAYER_1) {
      foregroundHealthPaint.color = Palette.MISSILE_OWNER_PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundHealthPaint.color = Palette.MISSILE_OWNER_PLAYER_2;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundHealthPaint);

    final double healthBar = width;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, healthBar, height),
      foregroundHealthPaint,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderHealthPaint);
  }
}
