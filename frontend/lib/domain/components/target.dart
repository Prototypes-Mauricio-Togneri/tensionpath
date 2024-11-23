import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';

abstract class Target {
  void onHit(double damage);

  double distance(Unit unit);

  bool isInLane(Lane lane);

  bool get isAlive;
}
