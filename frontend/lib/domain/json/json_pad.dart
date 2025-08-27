import 'package:json_annotation/json_annotation.dart';

part 'json_pad.g.dart';

@JsonSerializable()
class JsonPad {
  @JsonKey(name: 'platformId')
  final String platformId;

  const JsonPad({required this.platformId});

  factory JsonPad.fromJson(Map<String, dynamic> json) =>
      _$JsonPadFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPadToJson(this);
}
