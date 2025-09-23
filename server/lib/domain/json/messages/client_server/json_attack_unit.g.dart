// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_attack_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonAttackUnit _$JsonAttackUnitFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonAttackUnit', json, ($checkedConvert) {
      final val = JsonAttackUnit(
        matchId: $checkedConvert('matchId', (v) => v as String),
        attackerUnitId: $checkedConvert('attackerUnitId', (v) => v as String),
        defenderUnitId: $checkedConvert('defenderUnitId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonAttackUnitToJson(JsonAttackUnit instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'attackerUnitId': instance.attackerUnitId,
      'defenderUnitId': instance.defenderUnitId,
    };
