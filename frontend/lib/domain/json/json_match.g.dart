// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatch _$JsonMatchFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatch', json, ($checkedConvert) {
      final val = JsonMatch(
        id: $checkedConvert('id', (v) => v as String),
        version: $checkedConvert('version', (v) => (v as num).toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        players: $checkedConvert(
          'players',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) =>
                MapEntry(k, JsonPlayer.fromJson(e as Map<String, dynamic>)),
          ),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefield.fromJson(v as Map<String, dynamic>),
        ),
        config: $checkedConvert(
          'config',
          (v) => JsonConfig.fromJson(v as Map<String, dynamic>),
        ),
        turn: $checkedConvert(
          'turn',
          (v) => JsonTurn.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  if (dateToJson(instance.createdAt) case final value?) 'createdAt': value,
  'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
  'battlefield': instance.battlefield.toJson(),
  'config': instance.config.toJson(),
  'turn': instance.turn.toJson(),
};
