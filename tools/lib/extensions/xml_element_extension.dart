import 'package:xml/xml.dart';

extension XmlElementExtension on XmlElement {
  bool getBoolAttribute(String name, [bool defaultValue = false]) {
    try {
      return getAttribute(name) == 'true';
    } catch (e) {
      return defaultValue;
    }
  }

  num getNumAttribute(String name, [num defaultValue = 0]) {
    try {
      return num.parse(getAttribute(name) ?? '0');
    } catch (e) {
      return defaultValue;
    }
  }

  bool hasAttribute(String name) => getAttribute(name) != null;
}
