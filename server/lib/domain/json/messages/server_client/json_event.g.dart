// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEvent _$JsonEventFromJson(Map<String, dynamic> json) => $checkedCreate(
  'JsonEvent',
  json,
  ($checkedConvert) {
    final val = JsonEvent(
      missile: $checkedConvert(
        'missile',
        (v) => v == null
            ? null
            : JsonEventMissile.fromJson(v as Map<String, dynamic>),
      ),
      player: $checkedConvert(
        'player',
        (v) => v == null
            ? null
            : JsonEventPlayer.fromJson(v as Map<String, dynamic>),
      ),
      resourceDepleted: $checkedConvert(
        'resourceDepleted',
        (v) => v == null
            ? null
            : JsonEventResourceDepleted.fromJson(v as Map<String, dynamic>),
      ),
      buildingUnlocked: $checkedConvert(
        'buildingUnlocked',
        (v) => v == null
            ? null
            : JsonEventBuildingUnlocked.fromJson(v as Map<String, dynamic>),
      ),
      unitCreated: $checkedConvert(
        'unitCreated',
        (v) => v == null
            ? null
            : JsonEventUnitCreated.fromJson(v as Map<String, dynamic>),
      ),
      unitMovementStarted: $checkedConvert(
        'unitMovementStarted',
        (v) => v == null
            ? null
            : JsonEventUnitMovementStarted.fromJson(v as Map<String, dynamic>),
      ),
      unitMovementEnded: $checkedConvert(
        'unitMovementEnded',
        (v) => v == null
            ? null
            : JsonEventUnitMovementEnded.fromJson(v as Map<String, dynamic>),
      ),
      unitAttack: $checkedConvert(
        'unitAttack',
        (v) => v == null
            ? null
            : JsonEventUnitAttack.fromJson(v as Map<String, dynamic>),
      ),
      matchFinished: $checkedConvert(
        'matchFinished',
        (v) => v == null
            ? null
            : JsonEventMatchFinished.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$JsonEventToJson(JsonEvent instance) => <String, dynamic>{
  'missile': ?instance.missile?.toJson(),
  'player': ?instance.player?.toJson(),
  'resourceDepleted': ?instance.resourceDepleted?.toJson(),
  'buildingUnlocked': ?instance.buildingUnlocked?.toJson(),
  'unitCreated': ?instance.unitCreated?.toJson(),
  'unitMovementStarted': ?instance.unitMovementStarted?.toJson(),
  'unitMovementEnded': ?instance.unitMovementEnded?.toJson(),
  'unitAttack': ?instance.unitAttack?.toJson(),
  'matchFinished': ?instance.matchFinished?.toJson(),
};
