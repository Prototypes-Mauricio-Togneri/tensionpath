import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/palette.dart';

class StructureMissileComponent extends SpriteComponent {
  late final MissileIndicatorComponent missileIndicator;

  StructureMissileComponent({
    required super.position,
    required super.size,
    required JsonMissile jsonMissile,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    missileIndicator = MissileIndicatorComponent(
      position: size / 2,
      size: Vector2(size.x * 0.7, size.y * 0.08),
      jsonMissile: jsonMissile,
    );
  }

  void reconfigure(JsonMissile json) => missileIndicator.reconfigure(json);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_MISSILE);

    add(missileIndicator);

    return super.onLoad();
  }
}

class MissileIndicatorComponent extends PositionComponent {
  JsonMissile jsonMissile;
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
    required super.position,
    required super.size,
    required this.jsonMissile,
  }) : super(anchor: Anchor.center);

  void reconfigure(JsonMissile json) {
    jsonMissile = json;

    final String? owner = json.owner;

    if (owner == null) {
      foregroundPaint.color = Palette.MISSILE_OWNER_NONE;
    } else if (owner == '') {
      foregroundPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.PLAYER_2;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double filled = (width * jsonMissile.charge) / jsonMissile.maxCharge;
    canvas.drawRect(Rect.fromLTWH(0, 0, filled, height), foregroundPaint);

    /*final double gap = size.x / 80;
    final double blockSize =
        (width - gap * (jsonMissile.maxCharge + 1)) / jsonMissile.maxCharge;

    for (int i = 0; i < jsonMissile.charge; i++) {
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

    for (int i = jsonMissile.charge; i < jsonMissile.maxCharge; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        placeholderPaint,
      );
    }*/
  }
}
