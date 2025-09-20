// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_match_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMatchTemplate _$JsonMatchTemplateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonMatchTemplate', json, ($checkedConvert) {
      final val = JsonMatchTemplate(
        players: $checkedConvert(
          'players',
          (v) => (v as List<dynamic>)
              .map(
                (e) => JsonPlayerTemplate.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
        ),
        battlefield: $checkedConvert(
          'battlefield',
          (v) => JsonBattlefieldTemplate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonMatchTemplateToJson(JsonMatchTemplate instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'battlefield': instance.battlefield.toJson(),
    };
