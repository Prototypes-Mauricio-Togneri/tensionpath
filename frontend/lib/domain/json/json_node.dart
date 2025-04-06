import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/domain/entities/nodes/node_missile.dart';
import 'package:tensionpath/domain/entities/nodes/node_platform.dart';
import 'package:tensionpath/domain/entities/nodes/node_resources.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_unit.dart';
import 'package:tensionpath/domain/types/node_type.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  @JsonKey(name: 'x')
  final int x;

  @JsonKey(name: 'y')
  final int y;

  @JsonKey(name: 'type')
  final NodeType type;

  @JsonKey(name: 'unit')
  final JsonUnit? unit;

  @JsonKey(name: 'player')
  final String? player;

  const JsonNode({
    required this.x,
    required this.y,
    required this.type,
    required this.unit,
    required this.player,
  });

  Node object(List<Player> players) {
    final Unit? nodeUnit = unit?.object(players);
    final Player? nodePlayer = Player.playerById(id: player, players: players);

    switch (type) {
      case NodeType.land:
        return NodeLand(x: x, y: y, nodeUnit: nodeUnit, nodePlayer: nodePlayer);
      case NodeType.resources:
        return NodeResources(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodePlayer: nodePlayer,
        );
      case NodeType.launcher:
        return NodeLauncher(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodePlayer: nodePlayer,
        );
      case NodeType.missile:
        return NodeMissile(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodePlayer: nodePlayer,
        );
      case NodeType.platform:
        return NodePlatform(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodePlayer: nodePlayer,
        );
    }
  }

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
