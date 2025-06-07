import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node implements Localizable {
  final NodeType type;
  final Location location;
  late Units? _units;
  Structure? _structure;
  bool _isRevealed = false;

  Node({
    required this.type,
    required this.location,
    required Units? units,
    required Structure? structure,
  }) {
    _units = units;
    _structure = structure;
  }

  NodeComponent<Node> component({
    required Vector2 position,
    required Vector2 size,
  }) => NodeComponent(node: this, position: position, size: size);

  String get id => location.id;

  Units? get units => _units;

  Structure? get structure => _structure;

  bool get hasUnits => _units != null;

  bool get hasStructure => _structure != null;

  bool get isRevealed => _isRevealed;

  @override
  Location get getLocation => location;

  void setRevealed(bool value) {
    _isRevealed = value;
  }

  /*bool isMovementTarget(Units unit) {
    final bool isAllowedTarget =
        ((_structure == null) || _structure!.type.canMoveUnit) &&
        type.canMoveUnit(unit);
    final bool hasMoves = unit.remainingMoves > 0;
    final bool inDistance = distance(unit) <= unit.movementRange;

    return isAllowedTarget && hasMoves && inDistance;
  }*/

  void replaceWith(Node newNode) {
    if ((newNode.units != null) && (_units != null)) {
      _units!.replaceWith(newNode.units!);
    } else {
      _units = newNode.units;
    }

    if ((newNode.structure != null) && (_structure != null)) {
      _structure!.replaceWith(newNode.structure!);
    } else {
      _structure = newNode.structure;
    }
  }

  bool belongsTo(Player player) =>
      (_units?.belongsTo(player) ?? false) ||
      (_structure?.belongsTo(player) ?? false);

  int distance(Localizable localizable) =>
      location.distance(localizable.getLocation);

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
