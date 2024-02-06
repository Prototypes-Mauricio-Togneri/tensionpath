import 'dart:io';
import 'package:tensionpath/extensions/xml_element_extension.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:tensionpath/models/battlefield.dart';
import 'package:tensionpath/models/path.dart';
import 'package:xml/xml.dart';

class BattlefieldGenerator extends BaseGenerator {
  const BattlefieldGenerator() : super('battlefields');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');
      final List<Path> paths = [];

      for (final XmlElement element in elements) {
        if (element.getStringAttribute('id') == 'paths') {
          for (final path in element.childElements) {
            final String id = path.getStringAttribute('id');
            final List<Vertex> vertices =
                getVertices(path.getStringAttribute('d'));

            paths.add(Path(
              name: id,
              vertices: vertices,
            ));
          }
        }
      }

      final Battlefield battlefield = Battlefield(paths: paths);
      print(battlefield);

      //final JsonGameObject gameObject = getGameObject(elements.first);
      write(entry, battlefield);
    }
  }
}
