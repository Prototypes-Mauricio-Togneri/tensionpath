// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEvent _$JsonEventFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEvent', json, ($checkedConvert) {
      final val = JsonEvent(
        unitCreated: $checkedConvert(
          'unit_created',
          (v) => v == null
              ? null
              : JsonEventUnitCreated.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    }, fieldKeyMap: const {'unitCreated': 'unit_created'});

Map<String, dynamic> _$JsonEventToJson(JsonEvent instance) => <String, dynamic>{
  'unit_created': ?instance.unitCreated?.toJson(),
};
