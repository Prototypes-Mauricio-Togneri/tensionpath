import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class Node {
  final JsonPosition position;
  Structure? _structure;

  Node({required this.position, required Structure? structure}) {
    _structure = structure;
  }

  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeComponent(node: this, position: position, size: size);

  String get id => position.id;

  Structure? get structure => _structure;

  bool get hasStructure => _structure != null;

  bool get hasLauncher => _structure?.type == StructureType.launcher;

  bool isDeploymentTarget(JsonPlayer self) {
    final bool isLauncher = hasLauncher;
    final bool isPlayer = belongsTo(self);

    return isLauncher && isPlayer;
  }

  bool isMovementTarget(Unit unit) {
    final bool isAllowedTarget =
        (_structure == null) || _structure!.type.canMoveUnit;
    final bool hasMoves = unit.remainingMoves > 0;
    const bool inDistance = true;
    //distance(unit) <= unit.movementRange;

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
    const bool inDistance = true;
    //distance(unit) >= unit.minAttackRange &&
    //distance(unit) <= unit.maxAttackRange;

    return hasOpponentBase && hasAttacks && canAttack && inDistance;
  }

  bool belongsTo(JsonPlayer player) => _structure?.belongsTo(player) ?? false;

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
