import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class FogComponent extends PositionComponent {
  final Paint layerPaint = Palette.paint(
    blurSigma: 10,
  );
  final Paint fogPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_FOG,
  );
  final Paint clearPaint = Palette.paint(
    blendMode: BlendMode.clear,
  );
  final Player self;
  final List<UnitComponent> unitComponents;
  final List<LauncherComponent> launcherComponents;
  final List<NodeComponent> nodeComponents;
  final Vector2 nodeSize;
  final Vector2 offset;

  FogComponent({
    required super.position,
    required super.size,
    required this.self,
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
    canvas.drawRect(
      Rect.fromLTWH(
        -100,
        -100,
        width + 200,
        height + 200,
      ),
      fogPaint,
    );

    final Set<Vector2> visibleNodes = {};

    for (final NodeComponent nodeComponent in nodeComponents) {
      nodeComponent.isVisible = false;
    }

    for (final LauncherComponent launcherComponent in launcherComponents) {
      launcherComponent.nodeComponent.visibleNodes(
        visibilityRange: Constants.LAUNCHER_VISIBILITY,
        nodes: nodeComponents,
        visibleNodes: visibleNodes,
      );
    }

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.belongsTo(self)) {
        final NodeComponent closestNode = unitComponent.closestNodeComponent;
        closestNode.visibleNodes(
          visibilityRange: unitComponent.type.visibilityRange,
          nodes: nodeComponents,
          visibleNodes: visibleNodes,
        );
      }
    }

    for (final Vector2 visibleNode in visibleNodes) {
      canvas.drawHexagon(
        center: visibleNode,
        size: nodeSize * 1.03,
        fillPaint: clearPaint,
      );
    }

    canvas.restore();
  }
}
