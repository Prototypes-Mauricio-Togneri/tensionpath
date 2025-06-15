import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
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

  JsonNode({
    required this.x,
    required this.y,
    required this.type,
    required this.unit,
    required this.structure,
  });

  Node object(List<Player> players) {
    final Location location = Location(x: x, y: y);

    return Node(
      location: location,
      type: type,
      unit: unit?.object(location: location, players: players),
      structure: structure?.object(location: location, players: players),
    );
  }

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
