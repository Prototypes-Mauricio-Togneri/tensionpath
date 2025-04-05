// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPlayer _$JsonPlayerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPlayer', json, ($checkedConvert) {
      final val = JsonPlayer(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        resources: $checkedConvert('resources', (v) => (v as num).toInt()),
        resourcesRate: $checkedConvert(
          'resourcesRate',
          (v) => (v as num).toInt(),
        ),
      );
      return val;
    });
