import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/launcher_component.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
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

    /*for (final LauncherComponent launcherComponent in launcherComponents) {
      final Offset center = launcherComponent.position.toOffset();
      canvas.drawCircle(
        center,
        Constants.LAUNCHER_VISIBILITY * nodeSize,
        clearPaint,
      );
    }

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.player.isSelf) {
        final Vector2 center = unitComponent.position - offset + (size / 2);
        canvas.drawCircle(
          center.toOffset(),
          unitComponent.type.visibilityRange * nodeSize,
          clearPaint,
        );
      }
    }*/

    final Set<Vector2> visibleNodes = {};

    for (final LauncherComponent launcherComponent in launcherComponents) {
      final NodeComponent? nodeComponent = match.getNodeAt(
        nodeTypes: NodeType.values,
        position: launcherComponent.absolutePosition,
      );

      if (nodeComponent != null) {
        visibleNodes.addAll(
          nodeComponent.visibleNodes(
            visibilityRange: Constants.LAUNCHER_VISIBILITY,
            nodes: nodeComponents,
          ),
        );
      }
    }

    print('Visible Nodes: $visibleNodes');

    /*for (final NodeComponent nodeComponent in nodeComponents) {
      final String nodeId = nodeComponent.location.id;

      for (final LauncherComponent launcherComponent in launcherComponents) {
        final String launcherId = launcherComponent.location.id;

        if (launcherId == nodeId) {
          visibleNodes.add(launcherComponent.position);
        }
      }

      for (final UnitComponent unitComponent in unitComponents) {
        final NodeComponent? closestNode = match.getNodeAt(
          nodeTypes: NodeType.canMove,
          position: unitComponent.absolutePosition,
        );

        if (unitComponent.player.isSelf &&
            (closestNode != null) &&
            (closestNode.location.id == nodeId)) {
          visibleNodes.add(closestNode.position);
        }
      }
    }*/

    for (final Vector2 visibleNode in visibleNodes) {
      canvas.drawHexagon(
        center: visibleNode,
        size: nodeSize,
        fillPaint: clearPaint,
      );

      /*canvas.drawCircle(
        visibleNode.toOffset(),
        nodeSize,
        clearPaint,
      );*/
    }

    canvas.restore();
  }
}
