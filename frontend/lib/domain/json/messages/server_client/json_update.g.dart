// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUpdate _$JsonUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUpdate', json, ($checkedConvert) {
      final val = JsonUpdate(
        events: $checkedConvert(
          'events',
          (v) => (v as List<dynamic>)
              .map((e) => JsonEvent.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonUpdateToJson(JsonUpdate instance) =>
    <String, dynamic>{
      'events': instance.events.map((e) => e.toJson()).toList(),
    };
