import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_missile.dart';
import 'package:tensionpath/domain/entities/nodes/node_platform.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_structure.dart';
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

  @JsonKey(name: 'structure')
  final JsonStructure? structure;

  const JsonNode({
    required this.x,
    required this.y,
    required this.type,
    required this.unit,
    required this.structure,
  });

  Node object(List<Player> players) {
    final Unit? nodeUnit = unit?.object(players);
    final Structure? nodeStructure = structure?.object(players);

    switch (type) {
      case NodeType.land:
        return NodeLand(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodeStructure: nodeStructure,
        );
      case NodeType.missile:
        return NodeMissile(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodeStructure: nodeStructure,
        );
      case NodeType.platform:
        return NodePlatform(
          x: x,
          y: y,
          nodeUnit: nodeUnit,
          nodeStructure: nodeStructure,
        );
    }
  }

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
