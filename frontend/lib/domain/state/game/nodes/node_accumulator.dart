import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';

abstract class NodeAccumulator extends Node {
  NodeAccumulator({
    required super.x,
    required super.y,
    required super.captureRate,
    required super.nodeSize,
  });

  bool canAccumulate();

  @override
  void update(double dt) {
    super.update(dt);

    if (canAccumulate()) {
      addAccumulated(Constants.NODE_CREDITS_RATE * dt);
    }
  }
}
