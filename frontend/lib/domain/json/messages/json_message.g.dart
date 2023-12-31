// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMessage _$JsonMessageFromJson(Map<String, dynamic> json) => JsonMessage(
      error: json['error'] == null
          ? null
          : JsonError.fromJson(json['error'] as Map<String, dynamic>),
      welcome: json['welcome'] == null
          ? null
          : JsonWelcome.fromJson(json['welcome'] as Map<String, dynamic>),
      update: json['update'] == null
          ? null
          : JsonUpdate.fromJson(json['update'] as Map<String, dynamic>),
      unitsLaunched: json['unitsLaunched'] == null
          ? null
          : JsonUnitsLaunched.fromJson(
              json['unitsLaunched'] as Map<String, dynamic>),
      joinRoom: json['joinRoom'] == null
          ? null
          : JsonJoinRoom.fromJson(json['joinRoom'] as Map<String, dynamic>),
      launchUnits: json['launchUnits'] == null
          ? null
          : JsonLaunchUnits.fromJson(
              json['launchUnits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonMessageToJson(JsonMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('error', instance.error);
  writeNotNull('welcome', instance.welcome);
  writeNotNull('update', instance.update);
  writeNotNull('unitsLaunched', instance.unitsLaunched);
  writeNotNull('joinRoom', instance.joinRoom);
  writeNotNull('launchUnits', instance.launchUnits);
  return val;
}
