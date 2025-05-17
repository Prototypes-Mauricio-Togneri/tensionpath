import 'dart:async';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/utils/dimensions.dart';

class NodeComponent<N extends Node> extends PositionComponent
    implements Reconfigurable {
  final N node;
  //UnitComponent? _unitComponent;
  //StructureComponent? _structureComponent;
  //FogComponent? _fogComponent;

  NodeComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.topLeft, priority: Priority.node.value);

  @override
  bool containsLocalPoint(Vector2 point) =>
      Dimensions.pointInHexagon(point: point, size: size);

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    /*if (node.hasStructure && (_structureComponent == null)) {
      _structureComponent = node.structure!.component(
        position: size / 2,
        size: size,
      );
      add(_structureComponent!);
    } else if (!node.hasStructure && (_structureComponent != null)) {
      remove(_structureComponent!);
      _structureComponent = null;
    }

    if (node.isRevealed) {
      if (_fogComponent != null) {
        match.remove(_fogComponent!);
        _fogComponent = null;
      }

      if (node.hasUnit && (_unitComponent == null)) {
        _unitComponent = node.unit!.component(
          node: node,
          position: absolutePosition,
          size: size / 1.5,
        );
        match.add(_unitComponent!);
      } else if (!node.hasUnit && (_unitComponent != null)) {
        match.remove(_unitComponent!);
        _unitComponent = null;
      }
    } else {
      if (_unitComponent != null) {
        match.remove(_unitComponent!);
        _unitComponent = null;
      }

      if (_fogComponent == null) {
        _fogComponent =
            _fogComponent = FogComponent(
              position: absolutePosition,
              size: size,
            );
        match.add(_fogComponent!);
      }
    }*/
  }

  /*@override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: '${node.location}',
      position: Vector2(size.x / 2, size.y / 4),
      size: size.x / 8,
      color: Colors.white,
    );

    canvas.drawText(
      text: '${absolutePosition.x.toInt()},${absolutePosition.y.toInt()}',
      position: Vector2(size.x / 2, size.y * 2 / 4),
      size: size.x / 8,
      color: Colors.white,
    );
  }*/
}
