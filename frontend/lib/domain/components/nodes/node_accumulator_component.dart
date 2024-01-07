import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_capturable_component.dart';

class NodeAccumulatorComponent extends NodeCapturableComponent {
  NodeAccumulatorComponent({
    required super.id,
    required super.rate,
    required super.position,
    required super.size,
    super.owner,
  });

  double _creditsAccumulated = 0;

  bool get hasCreditsAccumulated => creditsAccumulated > 0;

  double get creditsAccumulated => _creditsAccumulated.floorToDouble();

  void removeAccumulated(double value) => _creditsAccumulated -= value;

  @override
  void update(double dt) {
    super.update(dt);

    _creditsAccumulated += Constants.NODE_CREDITS_RATE * dt;
  }
}
