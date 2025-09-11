// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launchers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLaunchers _$JsonLaunchersFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonLaunchers', json, ($checkedConvert) {
      final val = JsonLaunchers(
        playerIndex: $checkedConvert('playerIndex', (v) => v as String),
        locations: $checkedConvert(
          'locations',
          (v) => (v as List<dynamic>)
              .map((e) => JsonLocation.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$JsonLaunchersToJson(JsonLaunchers instance) =>
    <String, dynamic>{
      'playerIndex': instance.playerIndex,
      'locations': instance.locations.map((e) => e.toJson()).toList(),
    };
