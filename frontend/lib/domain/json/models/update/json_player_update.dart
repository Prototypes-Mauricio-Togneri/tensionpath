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

  @JsonKey(name: 'harvesterCount')
  final int harvesterCount;

  JsonPlayerUpdate({
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
    required this.harvesterCount,
  });

  factory JsonPlayerUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerUpdateToJson(this);
}
