import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/start/json_platform_start.dart';

part 'json_missile_start.g.dart';

@JsonSerializable()
class JsonMissileStart {
  @JsonKey(name: 'location')
  final JsonLocation location;

  final JsonPosition position;

  @JsonKey(name: 'chargeMax')
  final num chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final num chargeBuffer;

  @JsonKey(name: 'chargeRate')
  final num chargeRate;

  @JsonKey(name: 'damage')
  final num damage;

  @JsonKey(name: 'platforms')
  final List<JsonPlatformStart> platforms;

  const JsonMissileStart({
    required this.location,
    required this.position,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.chargeRate,
    required this.damage,
    required this.platforms,
  });

  factory JsonMissileStart.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileStartToJson(this);
}
