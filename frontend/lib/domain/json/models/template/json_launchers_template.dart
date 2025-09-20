import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_launchers_template.g.dart';

@JsonSerializable()
class JsonLaunchersTemplate {
  @JsonKey(name: 'playerIndex')
  final String playerIndex;

  @JsonKey(name: 'locations')
  final List<JsonLocation> locations;

  const JsonLaunchersTemplate({
    required this.playerIndex,
    required this.locations,
  });

  factory JsonLaunchersTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonLaunchersTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonLaunchersTemplateToJson(this);
}
