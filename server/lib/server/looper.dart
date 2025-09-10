import 'package:tensionpath/domain/matches/match_manager.dart';

class Looper {
  final MatchManager matchManager;
  final DateTime initialTime = DateTime.now();
  double previous = 0;

  Looper(this.matchManager) {
    previous = currentTime;
  }

  double get currentTime =>
      DateTime.now().difference(initialTime).inMilliseconds / 1000;

  Future start() async {
    while (true) {
      final double current = currentTime;
      final double dt = current - previous;
      previous = current;

      matchManager.update(dt);

      await Future.delayed(const Duration(microseconds: 16666));
    }
  }
}
