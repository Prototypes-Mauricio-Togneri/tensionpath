import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/components/structure_component.dart';
import 'package:tensionpath/domain/components/unit_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/dimensions.dart';

class NodeComponent<N extends Node> extends PositionComponent
    with TapCallbacks {
  final N node;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  @override
  FutureOr onLoad() async {
    add(StructureComponent(node: node, position: size / 2, size: size));
    add(
      UnitComponent(
        self: match.match.self,
        node: node,
        position: size / 2,
        size: size,
      ),
    );

    return super.onLoad();
  }

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  void onTapUp(TapUpEvent event) => match.match.onDeployUnit(
    nodeTarget: node,
    level: game.controlPressed ? min(5, match.match.self.resources) : 1,
  );

  @override
  void onLongTapDown(TapDownEvent event) => match.match.onDeployMaxUnit(node);
}
