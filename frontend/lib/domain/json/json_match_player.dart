import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

part 'json_match_player.g.dart';

@JsonSerializable()
class JsonMatchPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'resources')
  final int resources;

  const JsonMatchPlayer({
    required this.id,
    required this.name,
    required this.baseHealth,
    required this.resources,
  });

  JsonMatchPlayer clone({String? name}) => JsonMatchPlayer(
    id: id,
    name: name ?? this.name,
    baseHealth: baseHealth,
    resources: resources,
  );

  Player object(bool isSelf) => Player(
    id: id,
    name: name,
    isSelf: isSelf,
    baseHealth: baseHealth,
    resources: resources,
  );

  factory JsonMatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchPlayerToJson(this);
}
