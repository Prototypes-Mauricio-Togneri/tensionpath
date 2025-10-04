// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_config_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonConfigTemplate _$JsonConfigTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonConfigTemplate', json, ($checkedConvert) {
  final val = JsonConfigTemplate(
    resourcesStart: $checkedConvert('resourcesStart', (v) => v as num),
    resourcesPerPatch: $checkedConvert('resourcesPerPatch', (v) => v as num),
    resourcesPassiveRate: $checkedConvert(
      'resourcesPassiveRate',
      (v) => v as num,
    ),
    resourcesHarvestRate: $checkedConvert(
      'resourcesHarvestRate',
      (v) => v as num,
    ),
    popcapRate: $checkedConvert('popcapRate', (v) => v as num),
    missileMaxCharge: $checkedConvert('missileMaxCharge', (v) => v as num),
    missileChargeBuffer: $checkedConvert(
      'missileChargeBuffer',
      (v) => v as num,
    ),
    missileChargeRate: $checkedConvert('missileChargeRate', (v) => v as num),
    missileDamage: $checkedConvert('missileDamage', (v) => v as num),
    baseHealth: $checkedConvert('baseHealth', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonConfigTemplateToJson(JsonConfigTemplate instance) =>
    <String, dynamic>{
      'resourcesStart': instance.resourcesStart,
      'resourcesPerPatch': instance.resourcesPerPatch,
      'resourcesPassiveRate': instance.resourcesPassiveRate,
      'resourcesHarvestRate': instance.resourcesHarvestRate,
      'popcapRate': instance.popcapRate,
      'missileMaxCharge': instance.missileMaxCharge,
      'missileChargeBuffer': instance.missileChargeBuffer,
      'missileChargeRate': instance.missileChargeRate,
      'missileDamage': instance.missileDamage,
      'baseHealth': instance.baseHealth,
    };
