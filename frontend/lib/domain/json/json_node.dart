import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_position.dart';
import 'package:tensionpath/domain/json/json_structure.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'structure')
  final JsonStructure? structure;

  const JsonNode({required this.position, required this.structure});

  Node object(List<Player> players) {
    final Location location = Location(x: position.x, y: position.y);

    return Node(
      location: location,
      structure: structure?.object(location: location, players: players),
    );
  }

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
