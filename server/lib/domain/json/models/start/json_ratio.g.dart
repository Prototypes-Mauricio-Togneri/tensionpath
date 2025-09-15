// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_ratio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRatio _$JsonRatioFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonRatio', json, ($checkedConvert) {
      final val = JsonRatio(
        width: $checkedConvert('width', (v) => (v as num).toDouble()),
        height: $checkedConvert('height', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonRatioToJson(JsonRatio instance) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
};
