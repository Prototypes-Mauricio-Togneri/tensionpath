// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchPlayer _$JsonMatchPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchPlayer', json, ($checkedConvert) {
      final val = JsonMatchPlayer(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        baseHealth: $checkedConvert('baseHealth', (v) => (v as num).toInt()),
        resources: $checkedConvert('resources', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchPlayerToJson(JsonMatchPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'baseHealth': instance.baseHealth,
      'resources': instance.resources,
    };
