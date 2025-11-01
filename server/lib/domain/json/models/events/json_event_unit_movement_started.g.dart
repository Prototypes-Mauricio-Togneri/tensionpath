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
    targetPositions: $checkedConvert(
      'targetPositions',
      (v) => (v as List<dynamic>)
          .map((e) => JsonPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitMovementStartedToJson(
  JsonEventUnitMovementStarted instance,
) => <String, dynamic>{
  'id': instance.id,
  'currentPosition': instance.currentPosition.toJson(),
  'targetPositions': instance.targetPositions.map((e) => e.toJson()).toList(),
};
