import 'package:tensionpath/server/dispatcher.dart';

class Looper {
  final Dispatcher dispatcher;
  final DateTime initialTime = DateTime.now();
  double previous = 0;

  Looper(this.dispatcher) {
    previous = currentTime;
  }

  double get currentTime =>
      DateTime.now().difference(initialTime).inMilliseconds / 1000;

  Future start() async {
    while (true) {
      final double current = currentTime;
      final double dt = current - previous;
      previous = current;

      dispatcher.update(dt);

      await Future.delayed(const Duration(microseconds: 16666));
    }
  }
}
