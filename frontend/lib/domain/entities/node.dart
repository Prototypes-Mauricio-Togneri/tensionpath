import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/node_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/structure_type.dart';
import 'package:tensionpath/utils/palette.dart';

class Node {
  final int x;
  final int y;
  Unit? _unit;
  Structure? _structure;
  bool _isRevealed = false;

  Node({
    required this.x,
    required this.y,
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

  String get id => '$x,$y';

  Unit get unit => _unit!;

  Structure get structure => _structure!;

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

  void replaceWith(Node newNode) {
    _unit = newNode._unit;
    _structure = newNode._structure;
  }

  void resetUnit() {
    _unit?.reset();
  }

  bool belongsTo(Player player) =>
      (_unit?.belongsTo(player) ?? false) ||
      (_structure?.belongsTo(player) ?? false);

  int distance(Node node) {
    final double distance =
        ((x - node.x).abs() +
            (x + y - node.x - node.y).abs() +
            (y - node.y).abs()) /
        2;

    return distance.toInt();
  }

  JsonNode withUnitDeployed(Unit unit) => JsonNode(
    x: x,
    y: y,
    unit: unit.toJson(),
    structure: _structure?.toJson(),
  );

  JsonNode withUnitUndeployed() =>
      JsonNode(x: x, y: y, unit: null, structure: _structure?.toJson());

  JsonNode toJson() => JsonNode(
    x: x,
    y: y,
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
      return (other.x == x) && (other.y == y);
    }
  }

  @override
  int get hashCode => Object.hash(x, y);
}
