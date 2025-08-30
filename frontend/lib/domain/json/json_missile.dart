import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_platform.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'owner')
  final String? owner;

  @JsonKey(name: 'chargeCurrent')
  final double chargeCurrent;

  @JsonKey(name: 'chargeMax')
  final double chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final double chargeBuffer;

  @JsonKey(name: 'platforms')
  final List<JsonPlatform> platforms;

  const JsonMissile({
    required this.position,
    required this.owner,
    required this.chargeCurrent,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
