// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMessage _$JsonMessageFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonMessage', json, ($checkedConvert) {
  final val = JsonMessage(
    check: $checkedConvert(
      'check',
      (v) => v == null
          ? null
          : JsonHealthCheck.fromJson(v as Map<String, dynamic>),
    ),
    join: $checkedConvert(
      'join',
      (v) =>
          v == null ? null : JsonJoinMatch.fromJson(v as Map<String, dynamic>),
    ),
    unlock: $checkedConvert(
      'unlock',
      (v) => v == null
          ? null
          : JsonUnlockBuilding.fromJson(v as Map<String, dynamic>),
    ),
    deploy: $checkedConvert(
      'deploy',
      (v) =>
          v == null ? null : JsonDeployUnit.fromJson(v as Map<String, dynamic>),
    ),
    action: $checkedConvert(
      'action',
      (v) =>
          v == null ? null : JsonUnitAction.fromJson(v as Map<String, dynamic>),
    ),
    surrender: $checkedConvert(
      'surrender',
      (v) => v == null
          ? null
          : JsonSurrenderMatch.fromJson(v as Map<String, dynamic>),
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
    error: $checkedConvert(
      'error',
      (v) => v == null ? null : JsonError.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonMessageToJson(JsonMessage instance) =>
    <String, dynamic>{
      'check': ?instance.check?.toJson(),
      'join': ?instance.join?.toJson(),
      'unlock': ?instance.unlock?.toJson(),
      'deploy': ?instance.deploy?.toJson(),
      'action': ?instance.action?.toJson(),
      'surrender': ?instance.surrender?.toJson(),
      'welcome': ?instance.welcome?.toJson(),
      'start': ?instance.start?.toJson(),
      'update': ?instance.update?.toJson(),
      'error': ?instance.error?.toJson(),
    };
