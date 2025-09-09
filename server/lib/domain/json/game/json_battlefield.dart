import 'package:json_annotation/json_annotation.dart';
import 'json_location.dart';
import 'json_missile.dart';
import 'json_ratio.dart';
import 'json_resource.dart';
import 'json_size.dart';
import 'json_unit.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'size')
  final JsonSize size;

  @JsonKey(name: 'gridRatio')
  final JsonRatio gridRatio;

  @JsonKey(name: 'missile')
  final JsonMissile missile;

  @JsonKey(name: 'resources')
  final List<JsonResource> resources;

  @JsonKey(name: 'launchers')
  final Map<String, List<JsonLocation>> launchers;

  @JsonKey(name: 'nodes')
  final List<JsonLocation> nodes;

  @JsonKey(name: 'units')
  final List<JsonUnit> units;

  const JsonBattlefield({
    required this.id,
    required this.size,
    required this.gridRatio,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
    required this.units,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
