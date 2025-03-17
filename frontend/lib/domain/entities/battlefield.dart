import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
import 'package:tensionpath/domain/entities/nodes/node_land.dart';
import 'package:tensionpath/domain/entities/nodes/node_launcher.dart';
import 'package:tensionpath/domain/entities/nodes/node_victory.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_node.dart';
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
    filePath: Assets.BATTLEFIELDS_W7H13,
    player1: self,
    player2: enemy,
  );

  factory Battlefield.w7h13({required Player self, required Player enemy}) {
    const int widthCells = 7;
    const int heightCells = 13;

    const double laneWidth = Constants.SCREEN_WIDTH / widthCells;
    const double nodeSize = laneWidth;

    final List<Node> nodes = [];

    const int midCellX = widthCells ~/ 2;
    const int midCellY = heightCells ~/ 2;

    for (int x = 0; x < widthCells; x++) {
      // Land nodes
      for (int y = 1; y <= heightCells - 2; y++) {
        if (x != midCellX || y != midCellY) {
          nodes.add(NodeLand(x: x, y: y, nodeSize: nodeSize));
        }
      }

      // Self launcher
      nodes.add(NodeLauncher(x: x, y: 0, nodeSize: nodeSize, player: self));
      // Enemy launcher
      nodes.add(
        NodeLauncher(
          x: x,
          y: heightCells - 1,
          nodeSize: nodeSize,
          player: enemy,
        ),
      );
    }

    // Victory node
    nodes.add(NodeVictory(x: midCellX, y: midCellY, nodeSize: nodeSize));

    return Battlefield(
      id: 'w5h9',
      nodes: nodes,
      size: const Size(nodeSize * widthCells, nodeSize * heightCells),
    );
  }

  static Future<Battlefield> fromJson({
    required String filePath,
    required Player player1,
    required Player player2,
  }) async {
    final String data = await rootBundle.loadString(filePath);
    final Map<String, dynamic> json = jsonDecode(data);
    final JsonBattlefield jsonBattlefield = JsonBattlefield.fromJson(json);
    final double nodeSize = jsonBattlefield.nodeSize;

    final List<Node> nodes = <Node>[];

    for (final JsonNode jsonNode in jsonBattlefield.nodes) {
      final int x = jsonNode.x;
      final int y = jsonNode.y;
      final String type = jsonNode.type;
      final Player player = jsonNode.player == '1' ? player1 : player2;

      switch (type) {
        case 'land':
          nodes.add(NodeLand(x: x, y: y, nodeSize: nodeSize));
          break;
        case 'launcher':
          nodes.add(
            NodeLauncher(x: x, y: y, nodeSize: nodeSize, player: player),
          );
          break;
        case 'victory':
          nodes.add(NodeVictory(x: x, y: y, nodeSize: nodeSize));
          break;
        default:
          throw Exception('Unknown node type: $type');
      }
    }

    return Battlefield(
      id: jsonBattlefield.id,
      nodes: nodes,
      size: const Size(840, 1560),
    );
  }
}
