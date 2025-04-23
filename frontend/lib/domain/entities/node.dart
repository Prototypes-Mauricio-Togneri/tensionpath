import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class Node implements Localizable {
  final NodeType type;
  final Location location;
  Unit? _unit;
  Structure? _structure;
  bool _isRevealed = false;

  Node({
    required this.type,
    required this.location,
    required Unit? unit,
    required Structure? structure,
  }) {
    _unit = unit;
    _structure = structure;
  }

  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeComponent(node: this, position: position, size: size);

  String get id => location.id;

  Unit? get unit => _unit;

  Structure? get structure => _structure;

  bool get hasUnit => _unit != null;

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
    final bool isEmpty = !hasUnit;

    return isLauncher && isPlayer && isEmpty;
  }

  bool isMovementTarget(Unit unit) {
    final bool isEmpty = !hasUnit;
    final bool isAllowedTarget =
        ((_structure == null) || _structure!.type.canMoveUnit) &&
        type.canMoveUnit(unit);
    final bool hasMoves = unit.remainingMoves > 0;
    final bool inDistance = distance(unit) <= unit.movementRange;

    return isEmpty && isAllowedTarget && hasMoves && inDistance;
  }

  bool isSwapTarget(Unit unit) {
    if (hasUnit) {
      final bool hasSelfUnit = (unit != _unit) && _unit!.belongsTo(unit.player);
      final bool haveMoves =
          (unit.remainingMoves > 0) && (_unit!.remainingMoves > 0);
      final bool inDistance =
          (distance(unit) <= unit.movementRange) &&
          (distance(unit) <= _unit!.movementRange);

      return hasSelfUnit && haveMoves && inDistance;
    } else {
      return false;
    }
  }

  bool isAttackUnitTarget(Unit unit) {
    final bool hasOpponentUnit = hasUnit && !_unit!.belongsTo(unit.player);
    final bool hasAttacks = unit.remainingAttacks > 0;
    final bool canAttack = hasUnit && unit.damageTo(_unit!) > 0;
    final bool inDistance =
        distance(unit) >= unit.minAttackRange &&
        distance(unit) <= unit.maxAttackRange;

    return hasOpponentUnit && hasAttacks && canAttack && inDistance;
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

  void replaceWith(Node newNode) {
    if ((newNode.unit != null) && (_unit != null)) {
      _unit!.replaceWith(newUnit: newNode.unit!, location: newNode.location);
    } else {
      _unit = newNode.unit;
    }

    if ((newNode.structure != null) && (_structure != null)) {
      _structure!.replaceWith(newNode.structure!);
    } else {
      _structure = newNode.structure;
    }
  }

  bool belongsTo(Player player) =>
      (_unit?.belongsTo(player) ?? false) ||
      (_structure?.belongsTo(player) ?? false);

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
