import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/domain/json/models/start/json_size.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'size')
  final JsonSize size;

  @JsonKey(name: 'missile')
  final JsonMissile missile;

  @JsonKey(name: 'resources')
  final List<JsonResource> resources;

  @JsonKey(name: 'launchers')
  final List<JsonLaunchers> launchers;

  @JsonKey(name: 'nodes')
  final List<JsonNode> nodes;

  const JsonBattlefield({
    required this.size,
    required this.missile,
    required this.resources,
    required this.launchers,
    required this.nodes,
  });

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
