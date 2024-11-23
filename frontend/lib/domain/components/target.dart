import 'package:tensionpath/domain/state/game/lane.dart';

abstract class Target {
  void onHit(double damage);

  bool isInLane(Lane lane);

  bool get isAlive;
}
