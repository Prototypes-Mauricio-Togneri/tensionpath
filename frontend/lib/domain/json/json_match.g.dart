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
        turn: $checkedConvert('turn', (v) => (v as num).toInt()),
        lastTurnStartedAt: $checkedConvert(
          'lastTurnStartedAt',
          (v) => DateTime.parse(v as String),
        ),
        activePlayer: $checkedConvert('activePlayer', (v) => v as String),
        players: $checkedConvert(
          'players',
          (v) =>
              (v as List<dynamic>)
                  .map((e) => JsonPlayer.fromJson(e as Map<String, dynamic>))
                  .toList(),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefield.fromJson(v as Map<String, dynamic>),
        ),
        config: $checkedConvert(
          'config',
          (v) => JsonConfig.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchToJson(JsonMatch instance) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'createdAt': dateToJson(instance.createdAt),
  'turn': instance.turn,
  'lastTurnStartedAt': dateToJson(instance.lastTurnStartedAt),
  'activePlayer': instance.activePlayer,
  'players': instance.players.map((e) => e.toJson()).toList(),
  'battlefield': instance.battlefield.toJson(),
  'config': instance.config.toJson(),
};
