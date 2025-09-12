// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchUpdate _$JsonMatchUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchUpdate', json, ($checkedConvert) {
      final val = JsonMatchUpdate(
        players: $checkedConvert(
          'players',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              k,
              JsonPlayerUpdate.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
        missile: $checkedConvert(
          'missile',
          (v) => JsonMissileUpdate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchUpdateToJson(JsonMatchUpdate instance) =>
    <String, dynamic>{
      'players': instance.players.map((k, e) => MapEntry(k, e.toJson())),
      'missile': instance.missile.toJson(),
    };
