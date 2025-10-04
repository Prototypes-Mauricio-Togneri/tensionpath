import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/template/json_battlefield_template.dart';
import 'package:tensionpath/domain/json/models/template/json_config_template.dart';

part 'json_match_template.g.dart';

@JsonSerializable()
class JsonMatchTemplate {
  @JsonKey(name: 'config')
  final JsonConfigTemplate config;

  @JsonKey(name: 'battlefield')
  final JsonBattlefieldTemplate battlefield;

  JsonMatchTemplate({
    required this.config,
    required this.battlefield,
  });

  factory JsonMatchTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchTemplateToJson(this);
}
