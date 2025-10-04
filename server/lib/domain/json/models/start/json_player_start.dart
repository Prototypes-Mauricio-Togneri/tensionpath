import 'package:json_annotation/json_annotation.dart';

part 'json_player_start.g.dart';

@JsonSerializable()
class JsonPlayerStart {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'isSelf')
  final bool isSelf;

  @JsonKey(name: 'index')
  final String index;

  @JsonKey(name: 'baseHealth')
  final num baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final num baseMaxHealth;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesPassiveRate')
  final num resourcesPassiveRate;

  @JsonKey(name: 'resourcesActiveRate')
  final num resourcesActiveRate;

  JsonPlayerStart({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.index,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
    required this.resourcesPassiveRate,
    required this.resourcesActiveRate,
  });

  factory JsonPlayerStart.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerStartToJson(this);
}
