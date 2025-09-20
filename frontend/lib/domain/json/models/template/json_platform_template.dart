import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_platform_template.g.dart';

@JsonSerializable()
class JsonPlatformTemplate {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'pads')
  final List<JsonLocation> pads;

  const JsonPlatformTemplate({
    required this.id,
    required this.pads,
  });

  factory JsonPlatformTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonPlatformTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlatformTemplateToJson(this);
}
