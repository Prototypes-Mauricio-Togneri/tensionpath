// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonError _$JsonErrorFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonError', json, ($checkedConvert) {
      final val = JsonError(
        message: $checkedConvert('message', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonErrorToJson(JsonError instance) => <String, dynamic>{
  'message': instance.message,
};
