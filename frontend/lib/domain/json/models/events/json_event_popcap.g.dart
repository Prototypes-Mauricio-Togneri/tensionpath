// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_event_popcap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonEventPopcap _$JsonEventPopcapFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonEventPopcap', json, ($checkedConvert) {
      final val = JsonEventPopcap(
        popcap: $checkedConvert('popcap', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$JsonEventPopcapToJson(JsonEventPopcap instance) =>
    <String, dynamic>{'popcap': instance.popcap};
