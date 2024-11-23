import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_unit_generator_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class NodeUnitGenerator extends NodeAccumulator {
  NodeUnitGenerator({
    required super.id,
    required super.lane,
    required super.position,
    required super.maxNodeSize,
  }) : super(captureRate: Constants.NODE_UNIT_GENERATOR_CAPTURE_RATE);

  @override
  NodeComponent get component => NodeUnitGeneratorComponent(
        node: this,
        position: position,
        size: size,
      );

  @override
  bool canAccumulate() => hasOwner;

  @override
  void onOwnerAssigned(Player owner) => clearAccumulated();

  @override
  void update(double dt) {
    super.update(dt);

    if (hasOwner && hasCreditsAccumulated) {
      removeAccumulated(1);
      engine.onSpawnUnit(
        lane: lane,
        player: owner!,
        node: this,
        unitType: UnitType.melee1,
      );
    }
  }
}
