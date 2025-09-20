// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launcher_start.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLauncherStart _$JsonLauncherStartFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonLauncherStart', json, ($checkedConvert) {
      final val = JsonLauncherStart(
        playerIndex: $checkedConvert('playerIndex', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => JsonLocation.fromJson(v as Map<String, dynamic>),
        ),
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonLauncherStartToJson(JsonLauncherStart instance) =>
    <String, dynamic>{
      'playerIndex': instance.playerIndex,
      'location': instance.location.toJson(),
      'position': instance.position.toJson(),
    };
