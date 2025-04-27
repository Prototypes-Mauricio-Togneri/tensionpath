import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_ratio.dart';
import 'package:tensionpath/domain/json/json_size.dart';

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

  @JsonKey(name: 'popcap')
  final int popcap;

  @JsonKey(name: 'nodes')
  final List<JsonNode> nodes;

  const JsonBattlefield({
    required this.id,
    required this.size,
    required this.gridRatio,
    required this.missile,
    required this.popcap,
    required this.nodes,
  });

  Battlefield object(List<Player> players) => Battlefield(
    id: id,
    nodes: nodes.map((node) => node.object(players)).toList(),
    size: size.object,
    gridRatio: gridRatio.object,
    missile: missile.object,
    popcap: popcap,
  );

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
