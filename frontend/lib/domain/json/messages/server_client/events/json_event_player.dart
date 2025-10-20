import 'package:json_annotation/json_annotation.dart';

part 'json_event_player.g.dart';

@JsonSerializable()
class JsonEventPlayer {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'baseHealth')
  final num baseHealth;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  @JsonKey(name: 'currentHarvesterCount')
  final int currentHarvesterCount;

  @JsonKey(name: 'maxHarvestersCount')
  final int maxHarvestersCount;

  const JsonEventPlayer({
    required this.id,
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
    required this.maxHarvestersCount,
  });

  bool hasChanged(JsonEventPlayer other) {
    return baseHealth != other.baseHealth ||
        resourcesRate != other.resourcesRate ||
        currentHarvesterCount != other.currentHarvesterCount ||
        maxHarvestersCount != other.maxHarvestersCount;
  }

  factory JsonEventPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonEventPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventPlayerToJson(this);
}
