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
}
