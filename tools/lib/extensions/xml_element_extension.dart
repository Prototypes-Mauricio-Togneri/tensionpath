import 'package:tensionpath/extensions/num_extension.dart';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:xml/xml.dart';

extension XmlElementExtension on XmlElement {
  String getStringAttribute(String name, [String defaultValue = '']) {
    try {
      return getAttribute(name) ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  bool getBoolAttribute(String name, [bool defaultValue = false]) {
    try {
      return getAttribute(name) == 'true';
    } catch (e) {
      return defaultValue;
    }
  }

  num getNumAttribute(String name, [num defaultValue = 0]) {
    try {
      return num.parse(getAttribute(name) ?? defaultValue.toString());
    } catch (e) {
      return defaultValue;
    }
  }

  bool hasAttribute(String name) => getAttribute(name) != null;

  List<Vertex> get vertices {
    final String path = getStringAttribute('d');
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
