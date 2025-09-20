import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/start/json_pad_start.dart';

part 'json_platform_start.g.dart';

@JsonSerializable()
class JsonPlatformStart {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'pads')
  final List<JsonPadStart> pads;

  const JsonPlatformStart({
    required this.id,
    required this.pads,
  });

  factory JsonPlatformStart.fromJson(Map<String, dynamic> json) =>
      _$JsonPlatformStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlatformStartToJson(this);
}
