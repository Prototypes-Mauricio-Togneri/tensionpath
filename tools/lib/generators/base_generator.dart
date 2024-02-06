import 'dart:convert';
import 'dart:io';
import 'package:xml/xml.dart';

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

    writeJson(entry, json);
    writeDart(entry, json);
  }

  void writeJson(FileSystemEntity entry, String json) {
    final String fileName = entry.uri.pathSegments.last.split('.')[0];
    final File output = File('output/$folder/$fileName.json');
    output.writeAsStringSync(json);
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

    final File outputDart =
        File('../frontend/lib/assets/$folder/$fileName.dart');
    outputDart.writeAsStringSync(content);
  }

  /*List<JsonGameObject> getGameObjects(XmlElement xml) {
    final List<JsonGameObject> result = [];

    for (final XmlElement element in xml.childElements) {
      result.add(getGameObject(element));
    }

    return result;
  }*/

  /*JsonGameObject getGameObject(XmlElement element) {
    final String id = element.getAttribute('id')!;
    final BodyType bodyType = element.getEnumAttribute(
      'bodyType',
      BodyType.values,
      BodyType.kinematic,
    );
    final PowerUpType? powerUpType = element.getEnumAttribute(
      'powerUpType',
      PowerUpType.values,
      null,
    );
    final num angle = element.getNumAttribute('angle');
    final num speed = element.getNumAttribute('speed');

    final List<JsonModel> models = [];
    final List<JsonBehavior> behaviors = [];

    if (element.childElements.isEmpty) {
      models.add(getModel(element, [0, 0]));
    } else {
      for (final XmlElement child in element.childElements) {
        if ((child.name.local == 'path') || (child.name.local == 'circle') || (child.name.local == 'ellipse')) {
          models.add(getModel(child, getTranslation(element)));
        }
      }
    }

    num minX = double.infinity;
    num maxX = -double.infinity;
    num minY = double.infinity;
    num maxY = -double.infinity;

    for (final JsonModel model in models) {
      final num localMinX = model.minX;
      final num localMaxX = model.maxX;
      final num localMinY = model.minY;
      final num localMaxY = model.maxY;

      if (localMinX < minX) {
        minX = localMinX;
      }

      if (localMaxX > maxX) {
        maxX = localMaxX;
      }

      if (localMinY < minY) {
        minY = localMinY;
      }

      if (localMaxY > maxY) {
        maxY = localMaxY;
      }
    }

    final num x = (minX + maxX) / 2;
    final num y = (minY + maxY) / 2;

    for (final JsonModel model in models) {
      model.adjustVertices(x, y);
    }

    for (final XmlElement child in element.childElements) {
      if (child.name.local == 'behavior') {
        behaviors.add(getBehavior(child, x, y));
      }
    }

    return JsonGameObject(
      body: JsonBody(
        id: id,
        type: bodyType,
        x: x.rounded(),
        y: y.rounded(),
        angle: angle.rounded(),
        speed: speed.rounded(),
        powerUpType: powerUpType,
      ),
      models: models,
      behaviors: behaviors,
    );
  }*/

  /*JsonModel getModel(XmlElement element, Vertex translation) {
    final String id = element.getAttribute('id')!;
    final bool fixture = element.getBoolAttribute('fixture');
    final bool graphic = element.getBoolAttribute('graphic');
    final ModelType modelType = element.getEnumAttribute(
      'modelType',
      ModelType.values,
      ModelType.polygon,
    );
    final num radius = element.getNumAttribute('r');
    final num width = element.getNumAttribute('rx');
    final num height = element.getNumAttribute('ry');
    final JsonStyle style = JsonStyle.create(element.getAttribute('style'))!;

    return JsonModel(
      id: id,
      fixture: fixture,
      graphic: graphic,
      type: modelType,
      vertices: getVertices(element, translation, modelType),
      radius: radius.rounded(),
      width: width.rounded(),
      height: height.rounded(),
      style: style,
    );
  }

  List<JsonDisplay> getDisplays(XmlElement xml) {
    final List<JsonDisplay> result = [];

    for (final XmlElement element in xml.childElements) {
      result.add(getDisplay(element));
    }

    return result;
  }

  JsonDisplay getDisplay(XmlElement element) {
    final List<JsonModel> models = [];
    num offset = 0;

    if (element.hasAttribute('offset')) {
      offset = element.getNumAttribute('offset');
    }

    if (element.childElements.isEmpty) {
      models.add(getModel(element, [0, 0]));
    } else {
      for (final XmlElement child in element.childElements) {
        if ((child.name.local == 'path') || (child.name.local == 'circle')) {
          models.add(getModel(child, getTranslation(element)));
        }
      }
    }

    return JsonDisplay(
      models: models,
      offset: offset,
    );
  }

  List<JsonGameText> getGameTexts(XmlElement xml) {
    final List<JsonGameText> result = [];

    for (final XmlElement element in xml.childElements) {
      result.add(getGameText(element));
    }

    return result;
  }

  JsonGameText getGameText(XmlElement element) {
    final num x = element.getNumAttribute('x');
    final num y = element.getNumAttribute('y');
    final String text = element.getAttribute('id')!;
    final JsonStyle style = JsonStyle.create(element.getAttribute('style'))!;

    return JsonGameText(
      x: x.rounded(),
      y: -y.rounded(),
      text: text,
      color: style.color,
      size: style.fontSize!,
    );
  }

  List<Vertex> getVertices(
    XmlElement element,
    Vertex translation,
    ModelType modelType,
  ) {
    if ((modelType == ModelType.polygon) || (modelType == ModelType.line)) {
      return getVerticesPolygon(element.getAttribute('d')!, translation);
    } else if ((modelType == ModelType.circle) || (modelType == ModelType.ellipse)) {
      return getVerticesCircle(element, translation);
    } else {
      return [];
    }
  }

  List<Vertex> getVerticesCircle(XmlElement element, Vertex translation) {
    final num x = element.getNumAttribute('cx');
    final num y = -element.getNumAttribute('cy');

    return [
      [
        (x + translation[0]).rounded(),
        (y + translation[1]).rounded(),
      ]
    ];
  }

  List<Vertex> getVerticesPolygon(String path, Vertex translation) {
    final List<Vertex> result = [];

    String command = '';
    num lastX = 0;
    num lastY = 0;

    for (final String element in path.split(' ')) {
      final String current = element.toUpperCase();

      if ((current == 'M') || (current == 'Z') || (current == 'L') || (current == 'H') || (current == 'V')) {
        command = current;
      } else if ((command == 'M') || (command == 'L')) {
        final List<String> coordinates = current.split(',');
        final num x = num.parse(coordinates[0]);
        final num y = -num.parse(coordinates[1]);
        result.add([
          (x + translation[0]).rounded(),
          (y + translation[1]).rounded(),
        ]);

        lastX = x;
        lastY = y;
      } else if (command == 'H') {
        final num value = num.parse(current);
        result.add([
          (value + translation[0]).rounded(),
          (lastY + translation[1]).rounded(),
        ]);

        lastX = value;
      } else if (command == 'V') {
        final num value = -num.parse(current);
        result.add([
          (lastX + translation[0]).rounded(),
          (value + translation[1]).rounded(),
        ]);

        lastY = value;
      }
    }

    return result;
  }

  Vertex getTranslation(XmlElement element) {
    final String? transform = element.getAttribute('transform');

    num translateX = 0;
    num translateY = 0;

    if ((transform != null) && transform.startsWith('translate')) {
      final List<String> coordinates = transform.replaceAll('translate(', '').replaceAll(')', '').split(',');

      if (coordinates.isNotEmpty) {
        translateX = double.parse(coordinates[0]);
      }

      if (coordinates.length > 1) {
        translateY = -double.parse(coordinates[1]);
      }
    }

    return [
      translateX.rounded(),
      translateY.rounded(),
    ];
  }

  JsonIcon getIcon(XmlElement element, num width, num height) {
    final String name = element.getAttribute('id')!;
    final List<JsonLayer> layers = [];

    for (final XmlElement child in element.childElements) {
      if (child.name.local == 'circle') {
        layers.add(getLayerCircle(child));
      } else if (child.name.local == 'path') {
        layers.add(getLayerPolygon(child));
      }
    }

    return JsonIcon(
      name: name,
      layers: layers,
      width: width,
      height: height,
    );
  }

  JsonLayer getLayerCircle(XmlElement element) {
    final JsonStyle style = JsonStyle.create(element.getAttribute('style'))!;
    final num cx = element.getNumAttribute('cx');
    final num cy = element.getNumAttribute('cy');
    final num r = element.getNumAttribute('r');

    return JsonLayer(
      circle: JsonLayerCircle(
        style: style,
        cx: cx.rounded(),
        cy: cy.rounded(),
        r: r.rounded(),
      ),
    );
  }

  JsonLayer getLayerPolygon(XmlElement element) {
    final JsonStyle style = JsonStyle.create(element.getAttribute('style'))!;
    final List<Vertex> vertices = getVerticesPolygon(element.getAttribute('d')!, [0, 0]);
    final bool open = element.getBoolAttribute('open');

    return JsonLayer(
      polygon: JsonLayerPolygon(
        style: style,
        vertices: vertices,
        open: open,
      ),
    );
  }*/
}
