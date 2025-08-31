import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/palette.dart';

class FogComponent extends PositionComponent {
  final Paint layerPaint = Palette.paint();
  final Paint fogPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_FOG,
  );
  final Paint clearPaint = Palette.paint(
    blendMode: BlendMode.clear,
  );
  final List<UnitComponent> unitComponents;
  final List<LauncherComponent> launcherComponents;
  final double nodeSize;

  FogComponent({
    required super.position,
    required super.size,
    required this.unitComponents,
    required this.launcherComponents,
    required this.nodeSize,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.fog.value,
       );

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Save a new layer so we can use BlendMode.clear
    canvas.saveLayer(null, layerPaint);

    // Draw the full-screen overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), fogPaint);

    for (final LauncherComponent launcherComponent in launcherComponents) {
      final Offset center = launcherComponent.position.toOffset();
      canvas.drawCircle(
        center,
        Constants.LAUNCHER_VISIBILITY * nodeSize,
        clearPaint,
      );
    }

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.player.isSelf) {
        final Offset center = unitComponent.position.toOffset();

        canvas.drawCircle(
          center,
          unitComponent.type.visibilityRange * nodeSize,
          clearPaint,
        );
      }
    }

    canvas.restore();
  }
}
