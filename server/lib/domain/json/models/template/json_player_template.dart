import 'package:json_annotation/json_annotation.dart';

part 'json_player_template.g.dart';

@JsonSerializable()
class JsonPlayerTemplate {
  @JsonKey(name: 'index')
  final String index;

  @JsonKey(name: 'baseHealth')
  final num baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final num baseMaxHealth;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesRateBase')
  final num resourcesRateBase;

  JsonPlayerTemplate({
    required this.index,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
    required this.resourcesRateBase,
  });

  factory JsonPlayerTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerTemplateToJson(this);
}
