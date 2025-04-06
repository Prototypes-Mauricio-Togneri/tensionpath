import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

part 'json_player.g.dart';

@JsonSerializable()
class JsonPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'resources')
  final int resources;

  @JsonKey(name: 'resourcesRate')
  final int resourcesRate;

  const JsonPlayer({
    required this.id,
    required this.name,
    required this.resources,
    required this.resourcesRate,
  });

  Player player(bool isSelf) => Player(
    id: id,
    name: name,
    isSelf: isSelf,
    resources: resources,
    resourcesRate: resourcesRate,
  );

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerToJson(this);
}
