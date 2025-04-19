import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/extensions/size_extension.dart';

class Battlefield {
  final String id;
  final List<Node> nodes;
  final Size size;
  final Size gridRatio;

  const Battlefield({
    required this.id,
    required this.nodes,
    required this.size,
    required this.gridRatio,
  });

  Node nodeByPosition(Location location) {
    for (final Node node in nodes) {
      if (node.location == location) {
        return node;
      }
    }

    throw Exception('Node not found at position ($location)');
  }

  JsonBattlefield toJson() => JsonBattlefield(
    id: id,
    size: size.toJsonSize(),
    gridRatio: gridRatio.toJsonRatio(),
    nodes: nodes.map((node) => node.toJson()).toList(),
  );
}
