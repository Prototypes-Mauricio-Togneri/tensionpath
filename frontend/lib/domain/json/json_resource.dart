import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_resource.g.dart';

@JsonSerializable()
class JsonResource {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'amountCurrent')
  final double amountCurrent;

  @JsonKey(name: 'amountMax')
  final double amountMax;

  const JsonResource({
    required this.position,
    required this.amountCurrent,
    required this.amountMax,
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}
