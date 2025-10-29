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
    resourcesDamage: $checkedConvert('resourcesDamage', (v) => v as num),
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
    popcapInitial: $checkedConvert('popcapInitial', (v) => (v as num).toInt()),
    popcapMax: $checkedConvert('popcapMax', (v) => (v as num).toInt()),
    popcapRate: $checkedConvert('popcapRate', (v) => v as num),
    missileMaxCharge: $checkedConvert(
      'missileMaxCharge',
      (v) => (v as num).toInt(),
    ),
    missileChargeBuffer: $checkedConvert(
      'missileChargeBuffer',
      (v) => (v as num).toInt(),
    ),
    missileChargeAlarm: $checkedConvert(
      'missileChargeAlarm',
      (v) => (v as num).toInt(),
    ),
    missileChargeRate: $checkedConvert('missileChargeRate', (v) => v as num),
    missileDamage: $checkedConvert('missileDamage', (v) => v as num),
    baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
    matchTimeout: $checkedConvert('matchTimeout', (v) => (v as num).toInt()),
    suddenDeathTimeout: $checkedConvert(
      'suddenDeathTimeout',
      (v) => (v as num).toInt(),
    ),
    suddenDeathDamage: $checkedConvert(
      'suddenDeathDamage',
      (v) => (v as num).toInt(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonConfigToJson(JsonConfig instance) =>
    <String, dynamic>{
      'resourcesStart': instance.resourcesStart,
      'resourcesPerPatch': instance.resourcesPerPatch,
      'resourcesDamage': instance.resourcesDamage,
      'resourcesPassiveRate': instance.resourcesPassiveRate,
      'resourcesActiveRate': instance.resourcesActiveRate,
      'maxHarvestersCount': instance.maxHarvestersCount,
      'harvesterReward': instance.harvesterReward,
      'popcapInitial': instance.popcapInitial,
      'popcapMax': instance.popcapMax,
      'popcapRate': instance.popcapRate,
      'missileMaxCharge': instance.missileMaxCharge,
      'missileChargeBuffer': instance.missileChargeBuffer,
      'missileChargeAlarm': instance.missileChargeAlarm,
      'missileChargeRate': instance.missileChargeRate,
      'missileDamage': instance.missileDamage,
      'baseHealth': instance.baseHealth,
      'matchTimeout': instance.matchTimeout,
      'suddenDeathTimeout': instance.suddenDeathTimeout,
      'suddenDeathDamage': instance.suddenDeathDamage,
    };
