// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayer _$JsonPlayerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonPlayer', json, ($checkedConvert) {
  final val = JsonPlayer(
    id: $checkedConvert('id', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
    baseMaxHealth: $checkedConvert('baseMaxHealth', (v) => (v as num).toInt()),
    resources: $checkedConvert('resources', (v) => (v as num).toInt()),
    resourcesRate: $checkedConvert('resourcesRate', (v) => (v as num).toInt()),
  );
  return val;
});

Map<String, dynamic> _$JsonPlayerToJson(JsonPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseHealth': instance.baseHealth,
      'baseMaxHealth': instance.baseMaxHealth,
      'resources': instance.resources,
      'resourcesRate': instance.resourcesRate,
    };
