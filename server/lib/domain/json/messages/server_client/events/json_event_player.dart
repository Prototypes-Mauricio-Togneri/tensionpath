import 'package:json_annotation/json_annotation.dart';

part 'json_event_player.g.dart';

@JsonSerializable()
class JsonEventPlayer {
  @JsonKey(name: 'health')
  final num health;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  @JsonKey(name: 'currentHarvesterCount')
  final int currentHarvesterCount;

  const JsonEventPlayer({
    required this.health,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
  });

  bool hasChanged(JsonEventPlayer other) {
    return health != other.health ||
        resourcesRate != other.resourcesRate ||
        currentHarvesterCount != other.currentHarvesterCount;
  }

  factory JsonEventPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonEventPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventPlayerToJson(this);
}
