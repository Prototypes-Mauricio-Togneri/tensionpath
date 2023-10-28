// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonMessage _$JsonMessageFromJson(Map<String, dynamic> json) => JsonMessage(
      type: json['type'] as String,
      payload: json['payload'],
    );

Map<String, dynamic> _$JsonMessageToJson(JsonMessage instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('payload', instance.payload);
  return val;
}
