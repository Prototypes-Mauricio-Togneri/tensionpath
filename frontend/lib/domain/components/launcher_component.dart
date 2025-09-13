import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';
import 'package:tensionpath/utils/palette.dart';

class LauncherComponent extends PositionComponent {
  final Player player;
  final NodeComponent nodeComponent;
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint borderPaint = Palette.paint(style: PaintingStyle.fill);
  late final double borderWidth;

  LauncherComponent({
    required super.position,
    required super.size,
    required this.player,
    required this.nodeComponent,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
       ) {
    borderWidth = size.x * 0.05;
    foregroundPaint.color = player.color;
    borderPaint.color = player.color.darken(0.3);
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  bool belongsTo(Player player) => player.id == this.player.id;

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
