import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/json_coordinates.dart';
import 'package:tensionpath/domain/json/json_location.dart';

part 'json_unit.g.dart';

@JsonSerializable()
class JsonUnit {
  @JsonKey(name: 'location')
  final JsonLocation location;

  @JsonKey(name: 'coordinates')
  final JsonCoordinates coordinates;

  @JsonKey(name: 'health')
  final double health;

  const JsonUnit({
    required this.location,
    required this.coordinates,
    required this.health,
  });

  factory JsonUnit.fromJson(Map<String, dynamic> json) =>
      _$JsonUnitFromJson(json);

  Map<String, dynamic> toJson() => _$JsonUnitToJson(this);
}
