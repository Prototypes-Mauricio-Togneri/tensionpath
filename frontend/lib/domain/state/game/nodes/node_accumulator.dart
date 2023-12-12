import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/state/game/nodes/node_capturable.dart';

abstract class NodeAccumulator extends NodeCapturable {
  NodeAccumulator({
    required super.id,
    required super.position,
    required super.rate,
  });

  double _creditsAccumulated = 0;

  bool get hasCreditsAccumulated => creditsAccumulated > 0;

  double get creditsAccumulated => _creditsAccumulated.floorToDouble();

  bool get canAccumulate;

  void removeAccumulated(double value) => _creditsAccumulated -= value;

  @override
  bool update(double dt) {
    if (canAccumulate) {
      _creditsAccumulated += Constants.NODE_CREDITS_RATE * dt;
    }

    return super.update(dt);
  }
}
