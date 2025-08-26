import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class Node implements Localizable {
  final Location location;
  Structure? _structure;
  bool _isRevealed = false;

  Node({required this.location, required Structure? structure}) {
    _structure = structure;
  }

  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeComponent(node: this, position: position, size: size);

  String get id => location.id;

  Structure? get structure => _structure;

  bool get hasStructure => _structure != null;

  bool get hasLauncher => _structure?.type == StructureType.launcher;

  bool get isRevealed => _isRevealed;

  @override
  Location get getLocation => location;

  void setRevealed(bool value) {
    _isRevealed = value;
  }

  bool isDeploymentTarget(Player self) {
    final bool isLauncher = hasLauncher;
    final bool isPlayer = belongsTo(self);

    return isLauncher && isPlayer;
  }

  bool isMovementTarget(Unit unit) {
    final bool isAllowedTarget =
        (_structure == null) || _structure!.type.canMoveUnit;
    final bool hasMoves = unit.remainingMoves > 0;
    final bool inDistance = distance(unit) <= unit.movementRange;

    return isAllowedTarget && hasMoves && inDistance;
  }

  bool isAttackUnitTarget(Unit unit) {
    /*final bool hasAttacks = unit.remainingAttacks > 0;
    final bool canAttack = hasUnit && unit.damageTo(_unit!) > 0;
    final bool inDistance =
        distance(unit) >= unit.minAttackRange &&
        distance(unit) <= unit.maxAttackRange;*/

    return false;
  }

  bool isAttackBaseTarget(Unit unit) {
    final bool hasOpponentBase =
        hasStructure &&
        (_structure!.type == StructureType.launcher) &&
        (_structure!.getPlayerId != unit.player.id);
    final bool hasAttacks = unit.remainingAttacks > 0;
    final bool canAttack = unit.type.damageStructure > 0;
    final bool inDistance =
        distance(unit) >= unit.minAttackRange &&
        distance(unit) <= unit.maxAttackRange;

    return hasOpponentBase && hasAttacks && canAttack && inDistance;
  }

  bool belongsTo(Player player) => _structure?.belongsTo(player) ?? false;

  int distance(Localizable localizable) => location.distance(localizable);

  Set<String> visibleNodes({
    required int visibilityRange,
    required List<Node> nodes,
  }) {
    final Set<String> result = {id};

    for (final Node node in nodes) {
      if ((node != this) && (distance(node) <= visibilityRange)) {
        result.add(node.id);
      }
    }

    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Node) {
      return false;
    } else {
      return (other.id == id);
    }
  }

  @override
  int get hashCode => id.hashCode;
}
