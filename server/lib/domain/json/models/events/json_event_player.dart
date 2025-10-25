import 'package:json_annotation/json_annotation.dart';

part 'json_event_player.g.dart';

@JsonSerializable()
class JsonEventPlayer {
  @JsonKey(name: 'index')
  final String index;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  @JsonKey(name: 'currentHarvesterCount')
  final int currentHarvesterCount;

  @JsonKey(name: 'maxHarvestersCount')
  final int maxHarvestersCount;

  const JsonEventPlayer({
    required this.index,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
    required this.maxHarvestersCount,
  });

  factory JsonEventPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonEventPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonEventPlayerToJson(this);
}
