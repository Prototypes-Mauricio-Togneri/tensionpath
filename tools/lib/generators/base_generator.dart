import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/extensions/num_extension.dart';
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
    final String className = 'Models$folder$fileName';

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

  List<Vertex> getVertices(String path) {
    final List<Vertex> result = [];

    String command = '';
    num lastX = 0;
    num lastY = 0;

    for (final String element in path.split(' ')) {
      final String current = element.toUpperCase();

      if ((current == 'M') ||
          (current == 'Z') ||
          (current == 'L') ||
          (current == 'H') ||
          (current == 'V')) {
        command = current;
      } else if ((command == 'M') || (command == 'L')) {
        final List<String> coordinates = current.split(',');
        final num x = num.parse(coordinates[0]);
        final num y = num.parse(coordinates[1]);
        result.add([
          x.rounded(),
          y.rounded(),
        ]);

        lastX = x;
        lastY = y;
      } else if (command == 'H') {
        final num value = num.parse(current);
        result.add([
          value.rounded(),
          lastY.rounded(),
        ]);

        lastX = value;
      } else if (command == 'V') {
        final num value = -num.parse(current);
        result.add([
          lastX.rounded(),
          value.rounded(),
        ]);

        lastY = value;
      }
    }

    return result;
  }
}
