// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launcher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLauncher _$JsonLauncherFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonLauncher', json, ($checkedConvert) {
      final val = JsonLauncher(
        playerId: $checkedConvert('playerId', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$JsonLauncherToJson(JsonLauncher instance) =>
    <String, dynamic>{'playerId': instance.playerId};
