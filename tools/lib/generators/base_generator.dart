import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/extensions/string_extension.dart';
import 'package:xml/xml.dart';

typedef Vertex = List<num>;

class BaseGenerator {
  final String folder;

  const BaseGenerator(this.folder);

  List<FileSystemEntity> getFiles() {
    final Directory dir = Directory('input/$folder');
    return dir.listSync();
  }

  XmlDocument document(FileSystemEntity entry) {
    final File file = File(entry.path);
    return XmlDocument.parse(file.readAsStringSync());
  }

  void write(FileSystemEntity entry, Object object) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String json = encoder.convert(object);

    writeDart(entry, json);
  }

  void writeDart(FileSystemEntity entry, String json) {
    final String fileName = entry.uri.pathSegments.last.split('.')[0];
    final String className = 'Models${folder.capitalize}${fileName.capitalize}';

    final String content = '''
class $className {
  static const String JSON = \'\'\'
$json
\'\'\';
}
''';

    final File outputDart = File('output/$folder/$fileName.dart');
    outputDart.writeAsStringSync(content);
  }
}
