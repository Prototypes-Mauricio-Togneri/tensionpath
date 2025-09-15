import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_platform.g.dart';

@JsonSerializable()
class JsonPlatform {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'pads')
  final List<JsonLocation> pads;

  const JsonPlatform({
    required this.id,
    required this.pads,
  });

  factory JsonPlatform.fromJson(Map<String, dynamic> json) =>
      _$JsonPlatformFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlatformToJson(this);
}
