// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_pad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonPad _$JsonPadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonPad', json, ($checkedConvert) {
      final val = JsonPad(
        platformId: $checkedConvert('platformId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonPadToJson(JsonPad instance) => <String, dynamic>{
  'platformId': instance.platformId,
};
