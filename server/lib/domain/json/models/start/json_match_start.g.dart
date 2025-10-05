// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchStart _$JsonMatchStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchStart', json, ($checkedConvert) {
      final val = JsonMatchStart(
        createdAt: $checkedConvert('createdAt', (v) => v as String),
        maxHarvestersCount: $checkedConvert(
          'maxHarvestersCount',
          (v) => (v as num).toInt(),
        ),
        popcapRate: $checkedConvert('popcapRate', (v) => v as num),
        players: $checkedConvert(
          'players',
          (v) => (v as List<dynamic>)
              .map((e) => JsonPlayerStart.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefieldStart.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchStartToJson(JsonMatchStart instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'maxHarvestersCount': instance.maxHarvestersCount,
      'popcapRate': instance.popcapRate,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'battlefield': instance.battlefield.toJson(),
    };
