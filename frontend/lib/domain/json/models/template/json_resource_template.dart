import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_resource_template.g.dart';

@JsonSerializable()
class JsonResourceTemplate {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'amountCurrent')
  final num amountCurrent;

  @JsonKey(name: 'amountMax')
  final num amountMax;

  const JsonResourceTemplate({
    required this.id,
    required this.location,
    required this.amountCurrent,
    required this.amountMax,
  });

  factory JsonResourceTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceTemplateToJson(this);
}
