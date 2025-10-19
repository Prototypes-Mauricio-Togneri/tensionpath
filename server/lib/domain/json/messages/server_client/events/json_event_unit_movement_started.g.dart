// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_movement_started.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitMovementStarted _$JsonEventUnitMovementStartedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitMovementStarted', json, ($checkedConvert) {
  final val = JsonEventUnitMovementStarted(
    id: $checkedConvert('id', (v) => v as String),
    currentPosition: $checkedConvert(
      'currentPosition',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
    targetPosition: $checkedConvert(
      'targetPosition',
      (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitMovementStartedToJson(
  JsonEventUnitMovementStarted instance,
) => <String, dynamic>{
  'id': instance.id,
  'currentPosition': instance.currentPosition.toJson(),
  'targetPosition': instance.targetPosition.toJson(),
};
