import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';

part 'json_unit_update.g.dart';

@JsonSerializable()
class JsonUnitUpdate {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'position')
  final JsonPosition position;

  @JsonKey(name: 'health')
  final double health;

  const JsonUnitUpdate({
    required this.id,
    required this.location,
    required this.position,
    required this.health,
  });

  factory JsonUnitUpdate.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitUpdateToJson(this);
}
