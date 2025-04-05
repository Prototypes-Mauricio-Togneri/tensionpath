import 'package:json_annotation/json_annotation.dart';

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

  factory JsonPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerFromJson(json);
}
