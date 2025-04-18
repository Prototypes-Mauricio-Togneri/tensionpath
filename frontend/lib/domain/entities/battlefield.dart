import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_node.dart';
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

  JsonBattlefield deployUnit({required Node nodeTarget, required Unit unit}) {
    final List<JsonNode> jsonNodes = [];

    for (final Node node in nodes) {
      if (node == nodeTarget) {
        jsonNodes.add(nodeTarget.withUnitDeployed(unit));
      } else {
        jsonNodes.add(node.toJson());
      }
    }

    return JsonBattlefield(
      id: id,
      size: size.toJsonSize(),
      gridRatio: gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  JsonBattlefield moveUnit({
    required Node nodeOrigin,
    required Node nodeTarget,
  }) {
    final List<JsonNode> jsonNodes = [];
    final Unit unit = nodeOrigin.unit!;

    for (final Node node in nodes) {
      if (node == nodeOrigin) {
        jsonNodes.add(nodeOrigin.withUnitUndeployed());
      } else if (node == nodeTarget) {
        jsonNodes.add(nodeTarget.withUnitDeployed(unit));
      } else {
        jsonNodes.add(node.toJson());
      }
    }

    return JsonBattlefield(
      id: id,
      size: size.toJsonSize(),
      gridRatio: gridRatio.toJsonRatio(),
      nodes: jsonNodes,
    );
  }

  JsonBattlefield toJson() => JsonBattlefield(
    id: id,
    size: size.toJsonSize(),
    gridRatio: gridRatio.toJsonRatio(),
    nodes: nodes.map((node) => node.toJson()).toList(),
  );
}
