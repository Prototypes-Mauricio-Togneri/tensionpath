// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_unit_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUnitAction _$JsonUnitActionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUnitAction', json, ($checkedConvert) {
      final val = JsonUnitAction(
        matchId: $checkedConvert('matchId', (v) => v as String),
        unitId: $checkedConvert('unitId', (v) => v as String),
        targetLocation: $checkedConvert(
          'targetLocation',
          (v) => v == null
              ? null
              : JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        targetUnitId: $checkedConvert('targetUnitId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$JsonUnitActionToJson(JsonUnitAction instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'unitId': instance.unitId,
      'targetLocation': ?instance.targetLocation?.toJson(),
      'targetUnitId': ?instance.targetUnitId,
    };
