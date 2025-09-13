import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class PadComponent extends PositionComponent {
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderPaint = Palette.paint(style: PaintingStyle.fill);
  late final double borderWidth;
  final String platformId;
  String? owner;

  PadComponent({
    required super.position,
    required super.size,
    required this.platformId,
    required this.owner,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    borderWidth = size.x * 0.05;
    refresh();
  }

  void refresh() {
    if (owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.PLAYER_2;
    } else if (owner == '') {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (owner == null) {
      foregroundPaint.color = Palette.PLAYER_1;
    }

    borderPaint.color = foregroundPaint.color.darken(0.3);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawStructure(
      center: position,
      width: width,
      height: height,
      borderWidth: borderWidth,
      foregroundPaint: foregroundPaint,
      borderPaint: borderPaint,
    );
  }
}
