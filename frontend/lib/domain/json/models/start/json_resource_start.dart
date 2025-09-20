import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_resource_start.g.dart';

@JsonSerializable()
class JsonResourceStart {
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

  const JsonResourceStart({
    required this.id,
    required this.location,
    required this.position,
    required this.amountCurrent,
    required this.amountMax,
  });

  factory JsonResourceStart.fromJson(Map<String, dynamic> json) =>
      _$JsonResourceStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResourceStartToJson(this);
}
