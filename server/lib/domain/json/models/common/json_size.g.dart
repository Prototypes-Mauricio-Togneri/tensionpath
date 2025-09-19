// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonSize _$JsonSizeFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonSize', json, ($checkedConvert) {
      final val = JsonSize(
        width: $checkedConvert('width', (v) => v as num),
        height: $checkedConvert('height', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$JsonSizeToJson(JsonSize instance) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
};
