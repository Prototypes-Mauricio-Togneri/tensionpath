import 'package:json_annotation/json_annotation.dart';

part 'json_missile_update.g.dart';

@JsonSerializable()
class JsonMissileUpdate {
  @JsonKey(name: 'charge')
  final double charge;

  @JsonKey(name: 'platforms')
  final Map<String, String?> platforms;

  JsonMissileUpdate({
    required this.charge,
    required this.platforms,
  });

  factory JsonMissileUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileUpdateToJson(this);
}
