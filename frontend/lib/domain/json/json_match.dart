import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/domain/entities/nodes/node_missile.dart';
import 'package:tensionpath/domain/entities/nodes/node_platform.dart';
import 'package:tensionpath/domain/entities/nodes/node_resources.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/node_type.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'activePlayer')
  final String activePlayer;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  const JsonMatch({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.turn,
    required this.activePlayer,
    required this.players,
    required this.battlefield,
  });

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Player get self => players[0].player(true);

  Player get opponent => players[1].player(false);

  Battlefield getBattlefield(List<Player> players) {
    final List<Node> nodes = <Node>[];

    for (final JsonNode jsonNode in battlefield.nodes) {
      final int x = jsonNode.x;
      final int y = jsonNode.y;
      final NodeType type = jsonNode.type;
      final Player? player = playerById(id: jsonNode.player, players: players);

      switch (type) {
        case NodeType.land:
          nodes.add(NodeLand(x: x, y: y));
          break;
        case NodeType.resources:
          nodes.add(NodeResources(x: x, y: y));
          break;
        case NodeType.launcher:
          nodes.add(NodeLauncher(x: x, y: y, owner: player));
          break;
        case NodeType.missile:
          nodes.add(NodeMissile(x: x, y: y));
          break;
        case NodeType.platform:
          nodes.add(NodePlatform(x: x, y: y));
          break;
      }
    }

    return Battlefield(
      id: battlefield.id,
      nodes: nodes,
      size: Size(
        battlefield.size.width.toDouble(),
        battlefield.size.height.toDouble(),
      ),
      gridRatio: Size(
        battlefield.gridRatio.width.toDouble(),
        battlefield.gridRatio.height.toDouble(),
      ),
    );
  }

  Player? playerById({required String? id, required List<Player> players}) {
    if (id != null) {
      for (final Player player in players) {
        if (player.id == id) {
          return player;
        }
      }
    }

    return null;
  }
}
