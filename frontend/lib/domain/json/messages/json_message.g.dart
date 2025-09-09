// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMessage _$JsonMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonMessage', json, ($checkedConvert) {
  final val = JsonMessage(
    error: $checkedConvert(
      'error',
      (v) => v == null ? null : JsonError.fromJson(v as Map<String, dynamic>),
    ),
    welcome: $checkedConvert(
      'welcome',
      (v) => v == null ? null : JsonWelcome.fromJson(v as Map<String, dynamic>),
    ),
    update: $checkedConvert(
      'update',
      (v) => v == null ? null : JsonUpdate.fromJson(v as Map<String, dynamic>),
    ),
    joinBattle: $checkedConvert(
      'joinBattle',
      (v) =>
          v == null ? null : JsonJoinBattle.fromJson(v as Map<String, dynamic>),
    ),
    increaseMine: $checkedConvert(
      'increaseMine',
      (v) => v == null
          ? null
          : JsonIncreaseMine.fromJson(v as Map<String, dynamic>),
    ),
    increaseAttack: $checkedConvert(
      'increaseAttack',
      (v) => v == null
          ? null
          : JsonIncreaseAttack.fromJson(v as Map<String, dynamic>),
    ),
    launchUnits: $checkedConvert(
      'launchUnits',
      (v) => v == null
          ? null
          : JsonLaunchUnits.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonMessageToJson(JsonMessage instance) =>
    <String, dynamic>{
      'error': ?instance.error?.toJson(),
      'welcome': ?instance.welcome?.toJson(),
      'update': ?instance.update?.toJson(),
      'joinBattle': ?instance.joinBattle?.toJson(),
      'increaseMine': ?instance.increaseMine?.toJson(),
      'increaseAttack': ?instance.increaseAttack?.toJson(),
      'launchUnits': ?instance.launchUnits?.toJson(),
    };
