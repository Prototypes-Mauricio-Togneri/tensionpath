import 'dart:io';
import 'package:tensionpath/extensions/xml_element_extension.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:tensionpath/json/json_battlefield.dart';
import 'package:tensionpath/json/json_path.dart';
import 'package:xml/xml.dart';

class BattlefieldGenerator extends BaseGenerator {
  const BattlefieldGenerator() : super('battlefields');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');
      final List<JsonPath> paths = [];

      for (final XmlElement element in elements) {
        if (element.getStringAttribute('id') == 'lanes') {
          for (final path in element.childElements) {
            final String id = path.getStringAttribute('id');
            final List<Vertex> vertices =
                getVertices(path.getStringAttribute('d'));

            paths.add(JsonPath(
              name: id,
              vertices: vertices,
            ));
          }
        }
      }

      final JsonBattlefield battlefield = JsonBattlefield(paths: paths);
      write(entry, battlefield);
    }
  }
}
