import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
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
  final List<NodeComponent> nodeComponents;
  final Vector2 nodeSize;
  final Vector2 offset;

  FogComponent({
    required super.position,
    required super.size,
    required this.unitComponents,
    required this.launcherComponents,
    required this.nodeComponents,
    required this.nodeSize,
    required this.offset,
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

    final Set<Vector2> visibleNodes = {};

    for (final LauncherComponent launcherComponent in launcherComponents) {
      visibleNodes.addAll(
        launcherComponent.nodeComponent.visibleNodes(
          visibilityRange: Constants.LAUNCHER_VISIBILITY,
          nodes: nodeComponents,
        ),
      );
    }

    for (final UnitComponent unitComponent in unitComponents) {
      final NodeComponent? closestNode = unitComponent.closestNodeComponent;

      if (closestNode != null) {
        visibleNodes.addAll(
          closestNode.visibleNodes(
            visibilityRange: unitComponent.type.visibilityRange,
            nodes: nodeComponents,
          ),
        );
      }
    }

    for (final Vector2 visibleNode in visibleNodes) {
      canvas.drawHexagon(
        center: visibleNode,
        size: nodeSize,
        fillPaint: clearPaint,
      );
    }

    canvas.restore();
  }
}
