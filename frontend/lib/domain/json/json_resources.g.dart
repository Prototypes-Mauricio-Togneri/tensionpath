// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_resources.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResources _$JsonResourcesFromJson(Map<String, dynamic> json) =>
    $checkedCreate('JsonResources', json, ($checkedConvert) {
      final val = JsonResources(
        amount: $checkedConvert('amount', (v) => (v as num).toDouble()),
      );
      return val;
    });

Map<String, dynamic> _$JsonResourcesToJson(JsonResources instance) =>
    <String, dynamic>{'amount': instance.amount};
