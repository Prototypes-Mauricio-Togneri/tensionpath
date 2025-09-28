// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_surrender_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSurrenderMatch _$JsonSurrenderMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonSurrenderMatch', json, ($checkedConvert) {
      final val = JsonSurrenderMatch(
        matchId: $checkedConvert('matchId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonSurrenderMatchToJson(JsonSurrenderMatch instance) =>
    <String, dynamic>{'matchId': instance.matchId};
