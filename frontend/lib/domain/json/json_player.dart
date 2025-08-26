import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'baseMaxHealth')
  final int baseMaxHealth;

  @JsonKey(name: 'resources')
  final int resources;

  const JsonPlayer({
    required this.id,
    required this.name,
    required this.baseHealth,
    required this.baseMaxHealth,
    required this.resources,
  });

  JsonPlayer clone({String? name}) => JsonPlayer(
    id: id,
    name: name ?? this.name,
    baseHealth: baseHealth,
    baseMaxHealth: baseMaxHealth,
    resources: resources,
  );

  Player object(bool isSelf) => Player(
    id: id,
    name: name,
    isSelf: isSelf,
    baseHealth: baseHealth,
    baseMaxHealth: baseMaxHealth,
    resources: resources,
  );

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
