// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_movement_ended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitMovementEnded _$JsonEventUnitMovementEndedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitMovementEnded', json, ($checkedConvert) {
  final val = JsonEventUnitMovementEnded(
    id: $checkedConvert('id', (v) => v as String),
    currentPosition: $checkedConvert(
      'currentPosition',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    lockedLocation: $checkedConvert(
      'lockedLocation',
      (v) =>
          v == null ? null : JsonLocation.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitMovementEndedToJson(
  JsonEventUnitMovementEnded instance,
) => <String, dynamic>{
  'id': instance.id,
  'currentPosition': instance.currentPosition.toJson(),
  'lockedLocation': ?instance.lockedLocation?.toJson(),
};
