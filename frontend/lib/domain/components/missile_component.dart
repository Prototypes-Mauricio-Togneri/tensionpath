import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/presentation/audio/audio.dart';
import 'package:tensionpath/presentation/audio/sound.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/palette.dart';

class MissileComponent extends SpriteComponent {
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

    final bool alarmWasActive = missile.isAlarmActive;
    missile.charge(dt);
    final bool alarmIsActive = missile.isAlarmActive;

    if (!alarmWasActive && alarmIsActive) {
      Audio.get.playSound(Sound.EFFECT_MISSILE_ALARM);
    } else if (!alarmIsActive) {
      Audio.get.stopSound(Sound.EFFECT_MISSILE_ALARM);
    }
  }

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_MISSILE);

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

class MissileIndicatorComponent extends PositionComponent {
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_BACKGROUND,
  );
  final Paint borderPaint = Palette.paint(
    style: PaintingStyle.stroke,
    strokeWidth: 3,
    color: Palette.MISSILE_INDICATOR_BORDERR,
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
