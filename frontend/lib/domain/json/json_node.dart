import 'package:json_annotation/json_annotation.dart';
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

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);

  @override
  String toString() =>
      'JsonNode(x: $x, y: $y, type: $type, unit: $unit, player: $player)';
}
