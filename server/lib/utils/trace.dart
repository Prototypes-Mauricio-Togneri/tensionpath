class Trace {
  final String name;
  DateTime startTime = DateTime.now();
  int sum = 0;
  int count = 0;

  Trace({required this.name});

  void start() {
    startTime = DateTime.now();
  }

  void stop() {
    sum += DateTime.now().difference(startTime).inMilliseconds;
    count++;
  }

  num get average => (count == 0) ? 0 : (sum / count);

  @override
  String toString() => 'Trace($name): avg=${average}ms';
}
