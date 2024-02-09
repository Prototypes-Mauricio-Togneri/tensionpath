import 'dart:io';
import 'package:tensionpath/extensions/xml_element_extension.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:tensionpath/json/json_battlefield.dart';
import 'package:tensionpath/json/json_lane.dart';
import 'package:tensionpath/json/json_node.dart';
import 'package:tensionpath/json/json_waypoint.dart';
import 'package:xml/xml.dart';

class BattlefieldGenerator extends BaseGenerator {
  const BattlefieldGenerator() : super('battlefields');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');
      final List<JsonNode> nodes = [];
      final List<JsonLane> lanes = [];

      for (final XmlElement element in elements) {
        if (element.id == 'nodes') {
          nodes.addAll(_processNodes(element));
        }
      }

      for (final XmlElement element in elements) {
        if (element.id == 'lanes') {
          lanes.addAll(_processLanes(element, nodes));
        }
      }

      final JsonBattlefield battlefield = JsonBattlefield(lanes: lanes);
      write(entry, battlefield);
    }
  }

  List<JsonLane> _processLanes(XmlElement element, List<JsonNode> nodes) {
    final List<JsonLane> result = [];

    for (final XmlElement lane in element.childElements) {
      final List<Vertex> vertices = lane.vertices;
      final List<JsonWaypoint> waypoints = [];

      for (final Vertex vertex in vertices) {
        waypoints.add(JsonWaypoint(
          position: vertex,
          node: null,
        ));
      }

      result.add(JsonLane(
        id: lane.id,
        waypoints: waypoints,
      ));
    }

    return result;
  }

  List<JsonNode> _processNodes(XmlElement element) {
    final List<JsonNode> result = [];

    for (final XmlElement lane in element.childElements) {
      result.add(JsonNode(
        id: lane.id,
        position: lane.position,
      ));
    }

    return result;
  }
}
