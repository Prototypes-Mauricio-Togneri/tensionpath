import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_chest_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/state/game/nodes/node_accumulator.dart';

class NodeChest extends NodeAccumulator {
  NodeChest({
    required super.id,
    required super.lane,
    required super.position,
    required super.size,
  }) : super(captureRate: Constants.NODE_CHEST_CAPTURE_RATE);

  @override
  NodeComponent get component => NodeChestComponent(
        node: this,
        position: position,
        size: size,
      );

  @override
  bool canAccumulate() => creditsAccumulated < 10;

  @override
  void onTapped() {
    if (hasOwner && owner!.isSelf && hasCreditsAccumulated) {
      _claimCredits();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (hasOwner && owner!.isEnemy && hasCreditsAccumulated) {
      _claimCredits();
    }
  }

  void _claimCredits() {
    final double credits = creditsAccumulated;

    state.onAddCredits(
      player: owner!,
      credits: credits,
    );

    removeAccumulated(credits);
  }
}
