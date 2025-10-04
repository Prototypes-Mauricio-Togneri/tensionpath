import 'package:json_annotation/json_annotation.dart';

part 'json_config_template.g.dart';

@JsonSerializable()
class JsonConfigTemplate {
  @JsonKey(name: 'resourcesPerPatch')
  final num resourcesPerPatch;

  @JsonKey(name: 'resourcesRate')
  final num resourcesRate;

  @JsonKey(name: 'popcapRate')
  final num popcapRate;

  @JsonKey(name: 'missileMaxCharge')
  final num missileMaxCharge;

  @JsonKey(name: 'missileChargeBuffer')
  final num missileChargeBuffer;

  @JsonKey(name: 'missileChargeRate')
  final num missileChargeRate;

  @JsonKey(name: 'missileDamage')
  final num missileDamage;

  @JsonKey(name: 'baseHealth')
  final num baseHealth;

  const JsonConfigTemplate({
    required this.resourcesPerPatch,
    required this.resourcesRate,
    required this.popcapRate,
    required this.missileMaxCharge,
    required this.missileChargeBuffer,
    required this.missileChargeRate,
    required this.missileDamage,
    required this.baseHealth,
  });

  factory JsonConfigTemplate.fromJson(Map<String, dynamic> json) =>
      _$JsonConfigTemplateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonConfigTemplateToJson(this);
}
