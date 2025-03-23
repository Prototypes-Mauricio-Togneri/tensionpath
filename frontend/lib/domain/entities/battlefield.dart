import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/domain/entities/nodes/node_missile.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_node.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/assets.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
  });

  void update(double dt) {
    for (final Node node in nodes) {
      node.update(dt);
    }
  }

  static Future<Battlefield> create({
    required Player self,
    required Player enemy,
  }) async => Battlefield.fromJson(
    filePath: Assets.BATTLEFIELDS_W7H9,
    player1: self,
    player2: enemy,
  );

  static Future<Battlefield> fromJson({
    required String filePath,
    required Player player1,
    required Player player2,
  }) async {
    final String data = await rootBundle.loadString(filePath);
    final Map<String, dynamic> json = jsonDecode(data);
    final JsonBattlefield jsonBattlefield = JsonBattlefield.fromJson(json);

    final List<Node> nodes = <Node>[];

    for (final JsonNode jsonNode in jsonBattlefield.nodes) {
      final int x = jsonNode.x;
      final int y = jsonNode.y;
      final NodeType type = jsonNode.type;
      final Player player = jsonNode.player == '1' ? player1 : player2;

      switch (type) {
        case NodeType.land:
          nodes.add(NodeLand(x: x, y: y));
          break;
        case NodeType.launcher:
          nodes.add(NodeLauncher(x: x, y: y, player: player));
          break;
        case NodeType.missile:
          nodes.add(NodeMissile(x: x, y: y));
          break;
      }
    }

    return Battlefield(
      id: jsonBattlefield.id,
      nodes: nodes,
      size: Size(
        jsonBattlefield.width.toDouble(),
        jsonBattlefield.height.toDouble(),
      ),
    );
  }
}
