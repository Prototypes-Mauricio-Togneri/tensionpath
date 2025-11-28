import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class RewardComponent extends PositionComponent {
  final int reward;
  double percentage = 1;

  RewardComponent({
    required super.position,
    required super.size,
    required this.reward,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.reward.value,
       );

  @override
  void update(double dt) {
    super.update(dt);

    percentage -= dt;
    percentage = percentage.clamp(0, 1);

    position.y -= size.y * dt;

    if (percentage == 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '$reward${Constants.RESOURCE_ICON}',
      position: size/2,
      size: size.x,
      color: Palette.REWARD.withAlpha((percentage * 255).toInt()),
    );
  }
}
