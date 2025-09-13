import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/utils/map_list.dart';

class Launcher {
  final String playerIndex;
  final Location location;

  const Launcher({
    required this.playerIndex,
    required this.location,
  });

  static MapList<String, Launcher> list({
    required int width,
    required int height,
  }) {
    final MapList<String, Launcher> result = MapList();
    final int half = width ~/ 2;
    final int column1 = -half;
    final int column2 = half;

    for (final String playerIndex in ['1', '2']) {
      for (int i = 0; i < height; i++) {
        final Location location = Location(
          x: playerIndex == '1' ? column1 : column2,
          y: i,
        );
        final Launcher launcher = Launcher(
          playerIndex: playerIndex,
          location: location,
        );
        result.add(launcher.playerIndex, launcher);
      }
    }

    return result;
  }
}
