import 'package:tensionpath/battles/battle_manager.dart';

class Looper {
  final BattleManager battleManager;
  final DateTime initialTime = DateTime.now();
  double previous = 0;

  Looper(this.battleManager) {
    previous = currentTime;
  }

  double get currentTime =>
      DateTime.now().difference(initialTime).inMilliseconds / 1000;

  Future start() async {
    while (true) {
      final double current = currentTime;
      final double dt = current - previous;
      previous = current;

      battleManager.update(dt);

      await Future.delayed(const Duration(microseconds: 16666));
    }
  }
}
