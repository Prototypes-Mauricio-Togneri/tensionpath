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
  final int baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final int baseMaxHealth;

  @JsonKey(name: 'resources')
  final double resources;

  JsonPlayer({
    required this.id,
    required this.name,
    required this.isSelf,
    required this.index,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
  });

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
