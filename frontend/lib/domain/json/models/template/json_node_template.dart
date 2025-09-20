import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_node_template.g.dart';

@JsonSerializable()
class JsonNodeTemplate {
  @JsonKey(name: 'location')
  final JsonLocation location;

  JsonNodeTemplate({
    required this.location,
  });

  factory JsonNodeTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonNodeTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonNodeTemplateToJson(this);
}
