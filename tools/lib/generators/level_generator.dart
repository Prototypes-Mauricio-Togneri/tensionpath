import 'dart:io';
import 'package:tensionpath/generators/base_generator.dart';
import 'package:xml/xml.dart';

class LevelGenerator extends BaseGenerator {
  const LevelGenerator() : super('levels');

  void run() {
    final List<FileSystemEntity> entries = getFiles();
    final List<int> ids = [];

    for (final FileSystemEntity entry in entries) {
      final String fileName = entry.uri.pathSegments.last.split('.')[0];
      final int id = int.parse(fileName.split('_')[1]);
      ids.add(id);

      final XmlDocument xml = document(entry);
      print(xml);
      //final JsonLevel level = getLevel(xml, id);
      //write(entry, level);
    }
  }

  /*JsonLevel getLevel(XmlDocument document, int id) {
    final List<JsonGameObject> enemies = [];
    final List<JsonGameObject> portal = [];
    final List<JsonGameObject> spikes = [];
    final List<JsonGameObject> powerUps = [];
    final List<JsonGameObject> coins = [];
    final List<JsonGameText> texts = [];
    final List<JsonStars> stars = [];
    final Iterable<XmlElement> layers = document.findAllElements('g');

    for (final XmlElement layer in layers) {
      final String id = layer.getAttribute('id')!;

      if (id == 'enemies') {
        enemies.addAll(getGameObjects(layer));
      } else if (id == 'powerups') {
        powerUps.addAll(getGameObjects(layer));
      } else if (id == 'portal') {
        portal.addAll(getGameObjects(layer));
      } else if (id == 'spikes') {
        spikes.addAll(getGameObjects(layer));
      } else if (id == 'coins') {
        coins.addAll(getGameObjects(layer));
      } else if (id == 'texts') {
        texts.addAll(getGameTexts(layer));
      } else if (id == 'stars') {
        stars.addAll(getStars(layer));
      }
    }

    return JsonLevel(
      id: id,
      portal: portal[0],
      spikes: spikes[0],
      enemies: enemies,
      powerUps: powerUps,
      texts: texts,
      coins: coins,
      stars: stars[0],
    );
  }

  void _generateMapper(List<int> ids) {
    final List<String> imports = [];
    String mapperContent = '';

    for (final int id in ids) {
      imports
          .add("import 'package:tension_tunnel/assets/levels/level_$id.dart';");

      if (mapperContent.isEmpty) {
        mapperContent += '''
if (level == $id) {
  return ModelsLevelsLevel$id.JSON;
}
''';
      } else {
        mapperContent += '''
 else if (level == $id) {
  return ModelsLevelsLevel$id.JSON;
}
''';
      }
    }

    imports.sort((a, b) => a.compareTo(b));

    final String content = '''
${imports.join('\n')}

class LevelMapper {
  static String byId(int level) {
    $mapperContent
    else {
      throw Error();
    }
  }
}
''';

    final File outputDart =
        File('../frontend/lib/assets/$folder/level_mapper.dart');
    outputDart.writeAsStringSync(content);
  }*/
}
