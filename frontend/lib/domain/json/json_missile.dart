import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_location.dart';
import 'package:tensionpath/domain/json/json_platform.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'chargeMax')
  final double chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final double chargeBuffer;

  @JsonKey(name: 'platforms')
  final List<JsonPlatform> platforms;

  const JsonMissile({
    required this.location,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
