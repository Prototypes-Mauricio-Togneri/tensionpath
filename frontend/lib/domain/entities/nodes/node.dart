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

  String get id => '[$x,$y]';

  Color? get playerColor => _player?.color;

  bool get containsUnit => _unit != null;

  bool belongsTo(Player player) => _player == player;

  /*void deployUnit(Unit unit) {
    _unit = unit;
    _player = unit.player;
  }*/

  void undeployUnit() {
    _unit = null;
    _player = null;
  }

  void moveUnitTo(Node node) {
    //deployUnit(node._unit!);
    node.undeployUnit();
  }

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

  JsonNode toJson() => JsonNode(
    x: x,
    y: y,
    type: type,
    unit: _unit?.toJson(),
    player: _player?.id,
  );
}
