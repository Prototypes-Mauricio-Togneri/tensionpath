import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class Node {
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

  void setRevealed(bool value) {
    _isRevealed = value;
  }

  bool get isActionTarget =>
      (_structure?.type != StructureType.launcher) &&
      (_structure?.type != StructureType.missile);

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

  int distance(Node node) => location.distance(node.location);

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
