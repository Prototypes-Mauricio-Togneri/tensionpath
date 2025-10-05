import 'package:json_annotation/json_annotation.dart';

part 'json_player_update.g.dart';

@JsonSerializable()
class JsonPlayerUpdate {
  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'resources')
  final int resources;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  @JsonKey(name: 'currentHarvesterCount')
  final int currentHarvesterCount;

  @JsonKey(name: 'maxHarvesterCount')
  final int maxHarvesterCount;

  JsonPlayerUpdate({
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.currentHarvesterCount,
    required this.maxHarvesterCount,
  });

  factory JsonPlayerUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerUpdateToJson(this);
}
