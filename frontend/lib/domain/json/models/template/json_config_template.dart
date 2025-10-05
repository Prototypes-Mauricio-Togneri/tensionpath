import 'package:json_annotation/json_annotation.dart';

part 'json_config_template.g.dart';

@JsonSerializable()
class JsonConfigTemplate {
  @JsonKey(name: 'resourcesStart')
  final int resourcesStart;

  @JsonKey(name: 'resourcesPerPatch')
  final int resourcesPerPatch;

  @JsonKey(name: 'resourcesPassiveRate')
  final num resourcesPassiveRate;

  @JsonKey(name: 'resourcesActiveRate')
  final num resourcesActiveRate;

  @JsonKey(name: 'maxHarvestersCount')
  final int maxHarvestersCount;

  @JsonKey(name: 'harvesterReward')
  final int harvesterReward;

  @JsonKey(name: 'popcapRate')
  final num popcapRate;

  @JsonKey(name: 'missileMaxCharge')
  final int missileMaxCharge;

  @JsonKey(name: 'missileChargeBuffer')
  final int missileChargeBuffer;

  @JsonKey(name: 'missileChargeRate')
  final num missileChargeRate;

  @JsonKey(name: 'missileDamage')
  final int missileDamage;

  @JsonKey(name: 'baseHealth')
  final int baseHealth;

  const JsonConfigTemplate({
    required this.resourcesStart,
    required this.resourcesPerPatch,
    required this.resourcesPassiveRate,
    required this.resourcesActiveRate,
    required this.maxHarvestersCount,
    required this.harvesterReward,
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
