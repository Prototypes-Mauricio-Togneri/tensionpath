// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_health_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonHealthCheck _$JsonHealthCheckFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonHealthCheck', json, ($checkedConvert) {
      final val = JsonHealthCheck(
        id: $checkedConvert('id', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonHealthCheckToJson(JsonHealthCheck instance) =>
    <String, dynamic>{'id': instance.id};
