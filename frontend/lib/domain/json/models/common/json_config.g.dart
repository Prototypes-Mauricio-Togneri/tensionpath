// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonConfig _$JsonConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonConfig', json, ($checkedConvert) {
  final val = JsonConfig(
    resourcesStart: $checkedConvert(
      'resourcesStart',
      (v) => (v as num).toInt(),
    ),
    resourcesPerPatch: $checkedConvert(
      'resourcesPerPatch',
      (v) => (v as num).toInt(),
    ),
    resourcesPassiveRate: $checkedConvert(
      'resourcesPassiveRate',
      (v) => v as num,
    ),
    resourcesActiveRate: $checkedConvert(
      'resourcesActiveRate',
      (v) => v as num,
    ),
    maxHarvestersCount: $checkedConvert(
      'maxHarvestersCount',
      (v) => (v as num).toInt(),
    ),
    harvesterReward: $checkedConvert(
      'harvesterReward',
      (v) => (v as num).toInt(),
    ),
    popcapRate: $checkedConvert('popcapRate', (v) => v as num),
    missileMaxCharge: $checkedConvert(
      'missileMaxCharge',
      (v) => (v as num).toInt(),
    ),
    missileChargeBuffer: $checkedConvert(
      'missileChargeBuffer',
      (v) => (v as num).toInt(),
    ),
    missileChargeRate: $checkedConvert('missileChargeRate', (v) => v as num),
    missileDamage: $checkedConvert('missileDamage', (v) => (v as num).toInt()),
    baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$JsonConfigToJson(JsonConfig instance) =>
    <String, dynamic>{
      'resourcesStart': instance.resourcesStart,
      'resourcesPerPatch': instance.resourcesPerPatch,
      'resourcesPassiveRate': instance.resourcesPassiveRate,
      'resourcesActiveRate': instance.resourcesActiveRate,
      'maxHarvestersCount': instance.maxHarvestersCount,
      'harvesterReward': instance.harvesterReward,
      'popcapRate': instance.popcapRate,
      'missileMaxCharge': instance.missileMaxCharge,
      'missileChargeBuffer': instance.missileChargeBuffer,
      'missileChargeRate': instance.missileChargeRate,
      'missileDamage': instance.missileDamage,
      'baseHealth': instance.baseHealth,
    };
