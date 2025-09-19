import 'package:json_annotation/json_annotation.dart';

part 'json_player_update.g.dart';

@JsonSerializable()
class JsonPlayerUpdate {
  @JsonKey(name: 'baseHealth')
  final num baseHealth;

  @JsonKey(name: 'resources')
  final num resources;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  JsonPlayerUpdate({
    required this.baseHealth,
    required this.resources,
    required this.resourcesRate,
  });

  factory JsonPlayerUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerUpdateToJson(this);
}
