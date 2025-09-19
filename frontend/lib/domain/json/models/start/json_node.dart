import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/types/node_type.dart';

part 'json_node.g.dart';

@JsonSerializable()
class JsonNode {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  JsonPosition position;

  @JsonKey(name: 'type')
  NodeType type;

  JsonNode({
    required this.location,
    this.position = const JsonPosition(x: 0, y: 0),
    this.type = NodeType.empty,
  });

  factory JsonNode.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeToJson(this);
}
