import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/types/node_type.dart';

part 'json_node_template.g.dart';

@JsonSerializable()
class JsonNodeTemplate {
  @JsonKey(name: 'type')
  final NodeType type;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'playerIndex')
  final String? playerIndex;

  JsonNodeTemplate({
    required this.type,
    required this.location,
    required this.playerIndex,
  });

  factory JsonNodeTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeTemplateToJson(this);
}
