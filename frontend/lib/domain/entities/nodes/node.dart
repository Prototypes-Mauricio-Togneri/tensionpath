import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/node_type.dart';

abstract class Node {
  final NodeType type;
  final int x;
  final int y;
  Unit? _unit;
  Player? _player;

  Node({
    required this.type,
    required this.x,
    required this.y,
    required Unit? nodeUnit,
    required Player? nodePlayer,
  }) {
    _unit = nodeUnit;
    _player = nodePlayer;
  }

  NodeComponent component({required Vector2 position, required Vector2 size});

  Unit get unit => _unit!;

  Player get player => _player!;

  bool get hasPlayer => _player != null;

  String get id => '[$x,$y]';

  Color? get playerColor => _player?.color;

  bool get containsUnit => _unit != null;

  void replaceWith(Node newNode) {
    _unit = newNode._unit;

    if (newNode.hasPlayer) {
      if (_player != null) {
        _player?.replaceWith(newNode.player);
      } else {
        _player = newNode.player;
      }
    } else {
      _player = null;
    }
  }

  bool belongsTo(Player player) => _player == player;

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
    type: type,
    unit: unit.toJson(),
    player: unit.player.id,
  );

  JsonNode withUnitUndeployed() => JsonNode(
    x: x,
    y: y,
    type: type,
    unit: null,
    player: type == NodeType.launcher ? _player?.id : null,
  );

  JsonNode toJson() => JsonNode(
    x: x,
    y: y,
    type: type,
    unit: _unit?.toJson(),
    player: _player?.id,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    } else if (other is! Node) {
      return false;
    } else {
      return (other.x == x) && (other.y == y) && (other.type == type);
    }
  }

  @override
  int get hashCode => Object.hash(x, y, type);
}
