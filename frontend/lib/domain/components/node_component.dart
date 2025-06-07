import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:tensionpath/domain/components/structure_component.dart';
import 'package:tensionpath/domain/components/units_component.dart';
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
      UnitsComponent(
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
  void onTapUp(TapUpEvent event) =>
      match.match.onDeployUnit(nodeTarget: node, amount: 1);

  @override
  void onLongTapDown(TapDownEvent event) => match.match.onDeployMaxUnits(node);
}
