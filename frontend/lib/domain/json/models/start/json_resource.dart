import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';

part 'json_resource.g.dart';

@JsonSerializable()
class JsonResource {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'amountCurrent')
  final double amountCurrent;

  @JsonKey(name: 'amountMax')
  final double amountMax;

  const JsonResource({
    required this.id,
    required this.location,
    required this.amountCurrent,
    required this.amountMax,
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}
