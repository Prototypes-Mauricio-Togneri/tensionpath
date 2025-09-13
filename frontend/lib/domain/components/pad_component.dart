import 'dart:ui';
import 'package:flame/components.dart';
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
    foregroundPaint.color = Palette.PAD_BACKGROUND;
    refresh();
  }

  void refresh() {
    if (owner == Constants.PLAYER_1) {
      borderPaint.color = Palette.PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      borderPaint.color = Palette.PLAYER_2;
    } else if (owner == '') {
      borderPaint.color = Palette.PAD_CONTESTED;
    } else if (owner == null) {
      borderPaint.color = Palette.PAD_NEUTRAL;
    }
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
