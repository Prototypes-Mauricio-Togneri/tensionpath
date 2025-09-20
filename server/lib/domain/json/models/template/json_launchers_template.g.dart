// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_launchers_template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonLaunchersTemplate _$JsonLaunchersTemplateFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('JsonLaunchersTemplate', json, ($checkedConvert) {
  final val = JsonLaunchersTemplate(
    playerIndex: $checkedConvert('playerIndex', (v) => v as String),
    locations: $checkedConvert(
      'locations',
      (v) => (v as List<dynamic>)
          .map((e) => JsonLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JsonLaunchersTemplateToJson(
  JsonLaunchersTemplate instance,
) => <String, dynamic>{
  'playerIndex': instance.playerIndex,
  'locations': instance.locations.map((e) => e.toJson()).toList(),
};
