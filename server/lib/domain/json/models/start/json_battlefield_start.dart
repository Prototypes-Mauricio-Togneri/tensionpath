import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_size.dart';
import 'package:tensionpath/domain/json/models/start/json_launcher_start.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';

part 'json_battlefield_start.g.dart';

@JsonSerializable()
class JsonBattlefieldStart {
  @JsonKey(name: 'mapSize')
  final JsonSize mapSize;

  @JsonKey(name: 'nodeSize')
  final JsonSize nodeSize;

  @JsonKey(name: 'maxHarvestersCount')
  final int maxHarvestersCount;

  @JsonKey(name: 'missile')
  final JsonMissileStart missile;

  @JsonKey(name: 'resources')
  final List<JsonResourceStart> resources;

  @JsonKey(name: 'launchers')
  final List<JsonLauncherStart> launchers;

  @JsonKey(name: 'nodes')
  final List<JsonNodeStart> nodes;

  const JsonBattlefieldStart({
    required this.mapSize,
    required this.nodeSize,
    required this.maxHarvestersCount,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
  });

  factory JsonBattlefieldStart.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldStartFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldStartToJson(this);
}
