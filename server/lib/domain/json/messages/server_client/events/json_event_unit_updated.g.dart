// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_unit_updated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventUnitUpdated _$JsonEventUnitUpdatedFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonEventUnitUpdated', json, ($checkedConvert) {
  final val = JsonEventUnitUpdated(
    id: $checkedConvert('id', (v) => v as String),
    health: $checkedConvert('health', (v) => v as num),
  );
  return val;
});

Map<String, dynamic> _$JsonEventUnitUpdatedToJson(
  JsonEventUnitUpdated instance,
) => <String, dynamic>{'id': instance.id, 'health': instance.health};
