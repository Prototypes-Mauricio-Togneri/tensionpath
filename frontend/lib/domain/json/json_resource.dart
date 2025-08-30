import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_position.dart';

part 'json_resource.g.dart';

@JsonSerializable()
class JsonResource {
  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'amount')
  final double amount;

  const JsonResource({
    required this.position,
    required this.amount,
  });

  factory JsonResource.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceToJson(this);
}
