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
        size: Vector2(size.x * 0.7, size.y * 0.08),
      ),
    );

    return super.onLoad();
  }
}

class MissileIndicatorComponent extends PositionComponent {
  final Missile missile;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_BACKGROUND,
  );
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint placeholderPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_PLACEHOLDER,
  );

  MissileIndicatorComponent({
    required this.missile,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  void reconfigure() {
    final String? owner = missile.owner;

    if (owner == null) {
      foregroundPaint.color = Palette.MISSILE_OWNER_NONE;
    } else if (owner == '') {
      foregroundPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.MISSILE_OWNER_PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.MISSILE_OWNER_PLAYER_2;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double gap = size.x / 80;
    final double blockSize = (width - gap * 11) / 10;

    for (int i = 0; i < missile.charge; i++) {
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

    for (int i = missile.charge; i < missile.maxCharge; i++) {
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
