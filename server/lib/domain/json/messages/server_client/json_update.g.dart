// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonUpdate _$JsonUpdateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonUpdate', json, ($checkedConvert) {
      final val = JsonUpdate(
        match: $checkedConvert(
          'match',
          (v) => JsonMatchUpdate.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonUpdateToJson(JsonUpdate instance) =>
    <String, dynamic>{'match': instance.match.toJson()};
