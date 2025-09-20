import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/start/json_platform.dart';

part 'json_missile.g.dart';

@JsonSerializable()
class JsonMissile {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'chargeMax')
  final num chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final num chargeBuffer;

  @JsonKey(name: 'platforms')
  final List<JsonPlatform> platforms;

  const JsonMissile({
    required this.location,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
    this.position = const JsonPosition(x: 0, y: 0),
  });

  factory JsonMissile.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileToJson(this);
}
