import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/update/json_unit_update.dart';
import 'json_launchers.dart';
import 'json_missile.dart';
import 'json_ratio.dart';
import 'json_resource.dart';
import 'json_size.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'size')
  final JsonSize size;

  @JsonKey(name: 'gridRatio')
  final JsonRatio gridRatio;

  @JsonKey(name: 'missile')
  final JsonMissile missile;

  @JsonKey(name: 'resources')
  final List<JsonResource> resources;

  @JsonKey(name: 'launchers')
  final List<JsonLaunchers> launchers;

  @JsonKey(name: 'nodes')
  final List<JsonLocation> nodes;

  @JsonKey(name: 'units')
  final List<JsonUnitUpdate> units;

  const JsonBattlefield({
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
