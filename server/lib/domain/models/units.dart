import 'package:tensionpath/utils/constants.dart';

class Units {
  final int direction;
  final double totalDamage;
  double progress;

  Units({
    required this.direction,
    required this.totalDamage,
    required this.progress,
  });

  void update(double dt) {
    progress += dt * Constants.UNIT_SPEED;
  }
}
