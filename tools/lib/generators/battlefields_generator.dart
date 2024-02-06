import 'dart:io';
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
        if (element.getAttribute('id') == 'paths') {
          for (final path in element.childElements) {
            final List<Vertex> vertices = getVertices(path.getAttribute('d')!);
            paths.add(Path(
              name: path.getAttribute('id')!,
              vertices: vertices,
            ));
          }
        }
      }

      final Battlefield battlefield = Battlefield(paths: paths);
      print(battlefield);

      //final JsonGameObject gameObject = getGameObject(elements.first);
      //write(entry, gameObject);
    }
  }
}
