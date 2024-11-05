import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/domain/state/game/ownership.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/priority.dart';

class NodeComponent extends PositionComponent {
  final String id;
  late final Ownership ownership;

  NodeComponent({
    required this.id,
    required double rate,
    required super.position,
    required super.size,
    Player? owner,
  }) : super(
          anchor: Anchor.center,
          priority: Priority.node.value,
        ) {
    ownership = Ownership.create(
      node: this,
      rate: rate,
      owner: owner,
    );
  }

  bool get hasOwner => ownership.hasOwner;

  Player? get owner => ownership.owner;

  void spawnUnitOfPlayer(Player player) {
    final int power = player.creditsSelected;
    spawnUnit(power);
    player.spendCredits(power);
  }

  void spawnUnit(int power) {
    GameState.instance.onNodeSpawnUnit(
      node: this,
      power: power,
    );
  }

  void onOwnerAssigned(Player owner) {}

  void onOwnerUnassigned(Player owner) {}

  @override
  void update(double dt) => ownership.update(dt);
}
