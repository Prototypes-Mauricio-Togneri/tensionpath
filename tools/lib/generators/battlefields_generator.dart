import 'dart:io';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:xml/xml.dart';

class BattlefieldGenerator extends BaseGenerator {
  const BattlefieldGenerator() : super('battlefields');

  void run() {
    final List<FileSystemEntity> entries = getFiles();

    for (final FileSystemEntity entry in entries) {
      final XmlDocument xml = document(entry);
      final Iterable<XmlElement> elements = xml.findAllElements('g');

      for (final XmlElement element in elements) {
        print('${element.name} ${element.attributes}');
      }
      //final JsonGameObject gameObject = getGameObject(elements.first);
      //write(entry, gameObject);
    }
  }
}
