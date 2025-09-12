import 'package:json_annotation/json_annotation.dart';

part 'json_player_update.g.dart';

@JsonSerializable()
class JsonPlayerUpdate {
  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  @JsonKey(name: 'resources')
  final int resources;

  JsonPlayerUpdate({
    required this.baseHealth,
    required this.resources,
  });

  factory JsonPlayerUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlayerUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlayerUpdateToJson(this);
}
