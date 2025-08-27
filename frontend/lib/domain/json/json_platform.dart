import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_platform.g.dart';

@JsonSerializable()
class JsonPlatform {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'owner')
  final String? owner;

  const JsonPlatform({
    required this.id,
    required this.position,
    required this.owner,
  });

  factory JsonPlatform.fromJson(Map<String, dynamic> json) =>
      _$JsonPlatformFromJson(json);

  Map<String, dynamic> toJson() => _$JsonPlatformToJson(this);
}
