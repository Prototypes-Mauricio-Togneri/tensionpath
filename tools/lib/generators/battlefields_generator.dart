import 'dart:io';
import 'package:tensionpath/extensions/xml_element_extension.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:tensionpath/json/json_battlefield.dart';
import 'package:tensionpath/json/json_lane.dart';
import 'package:xml/xml.dart';

class BattlefieldGenerator extends BaseGenerator {
  const BattlefieldGenerator() : super('battlefields');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');
      final List<JsonLane> lanes = [];

      for (final XmlElement element in elements) {
        if (element.getStringAttribute('id') == 'lanes') {
          lanes.addAll(_processLanes(element));
        }
      }

      final JsonBattlefield battlefield = JsonBattlefield(lanes: lanes);
      write(entry, battlefield);
    }
  }

  List<JsonLane> _processLanes(final XmlElement element) {
    final List<JsonLane> result = [];

    for (final XmlElement lane in element.childElements) {
      result.add(JsonLane(
        name: lane.getStringAttribute('id'),
        vertices: lane.vertices,
      ));
    }

    return result;
  }
}
