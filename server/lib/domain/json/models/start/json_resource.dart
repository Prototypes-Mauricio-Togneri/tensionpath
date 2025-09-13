import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_resource.g.dart';

@JsonSerializable()
class JsonResource {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'location')
  final JsonLocation location;

  const JsonResource({
    required this.id,
    required this.location,
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}
