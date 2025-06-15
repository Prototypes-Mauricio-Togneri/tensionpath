import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_missile.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_size.dart';

part 'json_battlefield.g.dart';

@JsonSerializable()
class JsonBattlefield {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'size')
  final JsonSize size;

  @JsonKey(name: 'missile')
  final JsonMissile missile;

  @JsonKey(name: 'nodes')
  final List<JsonNode> nodes;

  JsonBattlefield({
    required this.id,
    required this.size,
    required this.missile,
    required this.nodes,
  });

  Battlefield object(List<Player> players) => Battlefield(
    id: id,
    nodes: nodes.map((node) => node.object(players)).toList(),
    size: size.object,
    missile: missile.object,
  );

  factory JsonBattlefield.fromJson(Map<String, dynamic> json) =>
      _$JsonBattlefieldFromJson(json);

  Map<String, dynamic> toJson() => _$JsonBattlefieldToJson(this);
}
