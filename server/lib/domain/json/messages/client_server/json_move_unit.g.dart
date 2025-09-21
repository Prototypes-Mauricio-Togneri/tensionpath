// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_move_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMoveUnit _$JsonMoveUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMoveUnit', json, ($checkedConvert) {
      final val = JsonMoveUnit(
        matchId: $checkedConvert('matchId', (v) => v as String),
        unitId: $checkedConvert('unitId', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMoveUnitToJson(JsonMoveUnit instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'unitId': instance.unitId,
      'location': instance.location.toJson(),
    };
