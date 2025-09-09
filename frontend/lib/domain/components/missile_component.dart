import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/json/game/json_missile.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/assets.dart';
import 'package:tensionpath/utils/palette.dart';

class MissileComponent extends SpriteComponent {
  late final MissileIndicatorComponent missileIndicator;

  MissileComponent({
    required super.position,
    required super.size,
    required JsonMissile missile,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    missileIndicator = MissileIndicatorComponent(
      position: size / 2,
      size: Vector2(size.x * 0.7, size.y * 0.08),
      chargeCurrent: 0,
      chargeMax: missile.chargeMax,
      chargeBuffer: missile.chargeBuffer,
      owner: null,
    );
  }

  void refresh(JsonMissile missile) => missileIndicator.refresh(missile);

  @override
  FutureOr onLoad() async {
    sprite = await Sprite.load(Assets.IMAGES_STRUCTURES_MISSILE);
    add(missileIndicator);

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
  double chargeCurrent;
  double chargeMax;
  double chargeBuffer;
  String? owner;

  MissileIndicatorComponent({
    required super.position,
    required super.size,
    required this.chargeCurrent,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.owner,
  }) : super(anchor: Anchor.center);

  void refresh(JsonMissile missile) {
    chargeCurrent = 0; // Fill with correct value
    chargeMax = missile.chargeMax;
    chargeBuffer = missile.chargeBuffer;
    owner = null; // Fill with correct value

    if (owner == '') {
      foregroundPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.PLAYER_2;
    }
  }

  @override
  void update(double dt) {
    if (owner == '') {
      if (chargeCurrent > chargeBuffer) {
        chargeCurrent -= dt;
      }
    } else if (owner != null) {
      chargeCurrent += dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double filled = (width * chargeCurrent) / chargeMax;
    canvas.drawRect(Rect.fromLTWH(0, 0, filled, height), foregroundPaint);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), borderPaint);
  }
}
