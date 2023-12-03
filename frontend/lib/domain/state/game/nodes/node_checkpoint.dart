import 'dart:math';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';

class NodeCheckpoint extends NodeCapturable {
  NodeCheckpoint({
    required super.id,
    required super.position,
  }) : super(rate: 0.1);

  void onSpawnUnit() => spawnUnit(Random().nextInt(10) + 1);
}
