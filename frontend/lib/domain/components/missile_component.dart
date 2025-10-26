import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class MissileComponent extends PositionComponent {
  final Missile missile;

  MissileComponent({
    required super.position,
    required super.size,
    required this.missile,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       );

  @override
  void update(double dt) {
    super.update(dt);

    missile.charge(dt);
  }

  @override
  FutureOr onLoad() async {
    add(
      MissileBackgroundComponent(
        position: size / 2,
        size: size,
        missile: missile,
      ),
    );

    add(
      MissileIndicatorComponent(
        position: size / 2,
        size: Vector2(size.x * 0.7, size.y * 0.08),
        missile: missile,
      ),
    );

    return super.onLoad();
  }
}

class MissileBackgroundComponent extends PositionComponent {
  final Missile missile;
  final Paint fillPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_OWNER_NONE,
  );
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_OWNER_NONE.darken(0.5),
  );

  MissileBackgroundComponent({
    required super.position,
    required super.size,
    required this.missile,
  }) : super(anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawHexagon(
      center: size / 2,
      size: size,
      fillPaint: fillPaint,
      borderPaint: borderPaint,
    );
  }
}

class MissileIndicatorComponent extends PositionComponent {
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_BACKGROUND,
  );
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 3,
    color: Palette.MISSILE_INDICATOR_BORDER,
  );
  final Paint foregroundPaint = Palette.paint(
    style: PaintingStyle.fill,
  );
  final Missile missile;

  MissileIndicatorComponent({
    required super.position,
    required super.size,
    required this.missile,
  }) : super(anchor: Anchor.center);

  @override
  void update(double dt) {
    if (missile.owner == '') {
      foregroundPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (missile.owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (missile.owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.PLAYER_2;
    } else {
      foregroundPaint.color = Palette.MISSILE_OWNER_NONE;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double filled = (width * missile.chargeCurrent) / missile.chargeMax;
    canvas.drawRect(Rect.fromLTWH(0, 0, filled, height), foregroundPaint);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);
  }
}
