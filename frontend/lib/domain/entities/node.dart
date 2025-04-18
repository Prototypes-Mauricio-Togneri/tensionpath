import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/structure_type.dart';
import 'package:tensionpath/utils/palette.dart';

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

  Color get color => _unit?.color ?? _structure?.color ?? Palette.transparent;

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

  void setUnit(Unit? unit) {
    _unit = unit;
  }

  void setStructure(Structure? structure) {
    _structure = structure;
  }

  void resetUnit() {
    _unit?.reset();
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

  JsonNode withUnitDeployed(Unit unit) => JsonNode(
    x: location.x,
    y: location.y,
    type: type,
    unit: unit.toJson(),
    structure: _structure?.toJson(),
  );

  JsonNode withUnitUndeployed() => JsonNode(
    x: location.x,
    y: location.y,
    type: type,
    unit: null,
    structure: _structure?.toJson(),
  );

  JsonNode toJson() => JsonNode(
    x: location.x,
    y: location.y,
    type: type,
    unit: _unit?.toJson(),
    structure: _structure?.toJson(),
  );

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
