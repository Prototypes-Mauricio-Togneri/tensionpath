import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/template/json_platform_template.dart';

part 'json_missile_template.g.dart';

@JsonSerializable()
class JsonMissileTemplate {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'chargeMax')
  final num chargeMax;

  @JsonKey(name: 'chargeBuffer')
  final num chargeBuffer;

  @JsonKey(name: 'platforms')
  final List<JsonPlatformTemplate> platforms;

  const JsonMissileTemplate({
    required this.location,
    required this.chargeMax,
    required this.chargeBuffer,
    required this.platforms,
  });

  factory JsonMissileTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonMissileTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMissileTemplateToJson(this);
}
