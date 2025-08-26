// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatch', json, ($checkedConvert) {
      final val = JsonMatch(
        id: $checkedConvert('id', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        players: $checkedConvert(
          'players',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlayer.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefield.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': dateToJson(instance.createdAt),
  'players': instance.players.map((e) => e.toJson()).toList(),
  'battlefield': instance.battlefield.toJson(),
};
