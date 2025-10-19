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
        'resource_depleted',
        (v) => v == null
            ? null
            : JsonEventResourceDepleted.fromJson(v as Map<String, dynamic>),
      ),
      unitCreated: $checkedConvert(
        'unit_created',
        (v) => v == null
            ? null
            : JsonEventUnitCreated.fromJson(v as Map<String, dynamic>),
      ),
      unitMovementStarted: $checkedConvert(
        'unit_movement_started',
        (v) => v == null
            ? null
            : JsonEventUnitMovementStarted.fromJson(v as Map<String, dynamic>),
      ),
      unitMovementEnded: $checkedConvert(
        'unit_movement_ended',
        (v) => v == null
            ? null
            : JsonEventUnitMovementEnded.fromJson(v as Map<String, dynamic>),
      ),
      unitUpdated: $checkedConvert(
        'unit_updated',
        (v) => v == null
            ? null
            : JsonEventUnitUpdated.fromJson(v as Map<String, dynamic>),
      ),
      unitDestroyed: $checkedConvert(
        'unit_destroyed',
        (v) => v == null
            ? null
            : JsonEventUnitDestroyed.fromJson(v as Map<String, dynamic>),
      ),
      matchFinished: $checkedConvert(
        'match_finished',
        (v) => v == null
            ? null
            : JsonEventMatchFinished.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'resourceDepleted': 'resource_depleted',
    'unitCreated': 'unit_created',
    'unitMovementStarted': 'unit_movement_started',
    'unitMovementEnded': 'unit_movement_ended',
    'unitUpdated': 'unit_updated',
    'unitDestroyed': 'unit_destroyed',
    'matchFinished': 'match_finished',
  },
);

Map<String, dynamic> _$JsonEventToJson(JsonEvent instance) => <String, dynamic>{
  'missile': ?instance.missile?.toJson(),
  'player': ?instance.player?.toJson(),
  'resource_depleted': ?instance.resourceDepleted?.toJson(),
  'unit_created': ?instance.unitCreated?.toJson(),
  'unit_movement_started': ?instance.unitMovementStarted?.toJson(),
  'unit_movement_ended': ?instance.unitMovementEnded?.toJson(),
  'unit_updated': ?instance.unitUpdated?.toJson(),
  'unit_destroyed': ?instance.unitDestroyed?.toJson(),
  'match_finished': ?instance.matchFinished?.toJson(),
};
