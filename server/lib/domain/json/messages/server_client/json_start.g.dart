// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonStart _$JsonStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonStart', json, ($checkedConvert) {
      final val = JsonStart(
        match: $checkedConvert(
          'match',
          (v) => JsonMatch.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonStartToJson(JsonStart instance) => <String, dynamic>{
  'match': instance.match.toJson(),
};
