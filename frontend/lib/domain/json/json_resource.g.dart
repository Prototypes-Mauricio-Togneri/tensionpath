// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResource _$JsonResourceFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonResource', json, ($checkedConvert) {
      final val = JsonResource(
        position: $checkedConvert(
          'position',
          (v) => JsonPosition.fromJson(v as Map<String, dynamic>),
        ),
        amount: $checkedConvert('amount', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonResourceToJson(JsonResource instance) =>
    <String, dynamic>{
      'position': instance.position.toJson(),
      'amount': instance.amount,
    };
