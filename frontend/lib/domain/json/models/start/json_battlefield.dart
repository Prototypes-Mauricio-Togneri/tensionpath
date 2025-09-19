import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/common/json_size.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'mapSize')
  final JsonSize mapSize;

  @JsonKey(name: 'nodeSize')
  final JsonSize nodeSize;

  @JsonKey(name: 'missile')
  final JsonMissile missile;

  @JsonKey(name: 'resources')
  final List<JsonResource> resources;

  @JsonKey(name: 'launchers')
  final List<JsonLaunchers> launchers;

  @JsonKey(name: 'nodes')
  final List<JsonNode> nodes;

  const JsonBattlefield({
    required this.mapSize,
    required this.nodeSize,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
