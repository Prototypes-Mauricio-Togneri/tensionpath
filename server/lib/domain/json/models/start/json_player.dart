import 'package:json_annotation/json_annotation.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'isSelf')
  bool isSelf;

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

  JsonPlayer({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.index,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
    required this.resourcesRateBase,
  });

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
