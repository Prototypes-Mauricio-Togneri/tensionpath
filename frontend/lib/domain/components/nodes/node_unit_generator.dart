import 'dart:async';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_accumulator_component.dart';
import 'package:tensionpath/domain/components/nodes/node_icon_component.dart';

class NodeUnitGeneratorComponent extends NodeAccumulatorComponent {
  NodeUnitGeneratorComponent({
    required super.node,
    required super.position,
    required super.size,
    super.owner,
  }) : super(rate: Constants.NODE_UNIT_GENERATOR_CAPTURE_RATE);

  @override
  FutureOr onLoad() {
    add(NodeIconComponent(
      icon: '🚀',
      parent: this,
    ));

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hasOwner && hasCreditsAccumulated) {
      removeAccumulated(1);
      spawnUnit(1);
    }
  }
}
