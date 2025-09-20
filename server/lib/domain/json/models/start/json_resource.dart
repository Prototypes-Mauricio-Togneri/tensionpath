import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_resource.g.dart';

@JsonSerializable()
class JsonResource {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'amountCurrent')
  final num amountCurrent;

  @JsonKey(name: 'amountMax')
  final num amountMax;

  const JsonResource({
    required this.id,
    required this.location,
    required this.amountCurrent,
    required this.amountMax,
    this.position = const JsonPosition(x: 0, y: 0),
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}
