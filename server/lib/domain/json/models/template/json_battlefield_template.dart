import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_size.dart';
import 'package:tensionpath/domain/json/models/template/json_node_template.dart';
import 'package:tensionpath/domain/json/models/template/json_platform_template.dart';

part 'json_battlefield_template.g.dart';

@JsonSerializable()
class JsonBattlefieldTemplate {
  @JsonKey(name: 'mapSize')
  final JsonSize mapSize;

  @JsonKey(name: 'nodeSize')
  final JsonSize nodeSize;

  @JsonKey(name: 'platforms')
  final List<JsonPlatformTemplate> platforms;

  @JsonKey(name: 'nodes')
  final List<JsonNodeTemplate> nodes;

  const JsonBattlefieldTemplate({
    required this.mapSize,
    required this.nodeSize,
    required this.platforms,
    required this.nodes,
  });

  factory JsonBattlefieldTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldTemplateToJson(this);
}
