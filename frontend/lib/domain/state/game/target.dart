import 'package:tensionpath/domain/state/game/units/unit.dart';

abstract class Target {
  void onHit(double damage);

  bool inRange(Unit unit, double range);

  bool get isAlive;
}
