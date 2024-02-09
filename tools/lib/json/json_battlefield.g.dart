// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_battlefield.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonBattlefield _$JsonBattlefieldFromJson(Map<String, dynamic> json) =>
    JsonBattlefield(
      lanes: (json['lanes'] as List<dynamic>)
          .map((e) => JsonLane.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JsonBattlefieldToJson(JsonBattlefield instance) =>
    <String, dynamic>{
      'lanes': instance.lanes,
    };
