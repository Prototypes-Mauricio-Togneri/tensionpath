import 'package:json_annotation/json_annotation.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'index')
  final String index;

  @JsonKey(name: 'isSelf')
  final bool isSelf;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final int baseMaxHealth;

  @JsonKey(name: 'resources')
  final double resources;

  const JsonPlayer({
    required this.id,
    required this.index,
    required this.isSelf,
    required this.name,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
  });

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
