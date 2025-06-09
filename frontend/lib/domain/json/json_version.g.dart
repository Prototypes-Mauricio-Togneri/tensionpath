// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonVersion _$JsonVersionFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JsonVersion',
  json,
  ($checkedConvert) {
    final val = JsonVersion(
      appName: $checkedConvert('app_name', (v) => v as String),
      version: $checkedConvert('version', (v) => v as String),
      buildNumber: $checkedConvert('build_number', (v) => v as String),
      packageName: $checkedConvert('package_name', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'appName': 'app_name',
    'buildNumber': 'build_number',
    'packageName': 'package_name',
  },
);

Map<String, dynamic> _$JsonVersionToJson(JsonVersion instance) =>
    <String, dynamic>{
      'app_name': instance.appName,
      'version': instance.version,
      'build_number': instance.buildNumber,
      'package_name': instance.packageName,
    };
