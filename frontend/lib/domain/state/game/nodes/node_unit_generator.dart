import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';

class NodeUnitGenerator extends NodeCapturable with NodeAccumulator {
  NodeUnitGenerator({
    required super.id,
    required super.position,
  }) : super(rate: Constants.NODE_UNIT_GENERATOR_CAPTURE_RATE);

  @override
  bool update(double dt) {
    if (hasOwner) {
      accumulate(dt);

      if (creditsAccumulated >= 1) {
        removeAccumulated(1);
        spawnUnit(1);
      }
    }

    return super.update(dt);
  }
}
