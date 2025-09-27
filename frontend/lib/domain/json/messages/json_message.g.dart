// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMessage _$JsonMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonMessage', json, ($checkedConvert) {
  final val = JsonMessage(
    join: $checkedConvert(
      'join',
      (v) =>
          v == null ? null : JsonJoinMatch.fromJson(v as Map<String, dynamic>),
    ),
    deploy: $checkedConvert(
      'deploy',
      (v) =>
          v == null ? null : JsonDeployUnit.fromJson(v as Map<String, dynamic>),
    ),
    move: $checkedConvert(
      'move',
      (v) =>
          v == null ? null : JsonMoveUnit.fromJson(v as Map<String, dynamic>),
    ),
    attackUnit: $checkedConvert(
      'attackUnit',
      (v) =>
          v == null ? null : JsonAttackUnit.fromJson(v as Map<String, dynamic>),
    ),
    action: $checkedConvert(
      'action',
      (v) =>
          v == null ? null : JsonUnitAction.fromJson(v as Map<String, dynamic>),
    ),
    welcome: $checkedConvert(
      'welcome',
      (v) => v == null ? null : JsonWelcome.fromJson(v as Map<String, dynamic>),
    ),
    start: $checkedConvert(
      'start',
      (v) => v == null ? null : JsonStart.fromJson(v as Map<String, dynamic>),
    ),
    update: $checkedConvert(
      'update',
      (v) => v == null ? null : JsonUpdate.fromJson(v as Map<String, dynamic>),
    ),
    finish: $checkedConvert(
      'finish',
      (v) => v == null ? null : JsonFinish.fromJson(v as Map<String, dynamic>),
    ),
    error: $checkedConvert(
      'error',
      (v) => v == null ? null : JsonError.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonMessageToJson(JsonMessage instance) =>
    <String, dynamic>{
      'join': ?instance.join?.toJson(),
      'deploy': ?instance.deploy?.toJson(),
      'move': ?instance.move?.toJson(),
      'attackUnit': ?instance.attackUnit?.toJson(),
      'action': ?instance.action?.toJson(),
      'welcome': ?instance.welcome?.toJson(),
      'start': ?instance.start?.toJson(),
      'update': ?instance.update?.toJson(),
      'finish': ?instance.finish?.toJson(),
      'error': ?instance.error?.toJson(),
    };
