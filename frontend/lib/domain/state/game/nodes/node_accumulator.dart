import 'package:tensionpath/app/constants.dart';

mixin NodeAccumulator {
  double _creditsAccumulated = 0;

  bool get hasCreditsAccumulated => creditsAccumulated > 0;

  double get creditsAccumulated => _creditsAccumulated.floorToDouble();

  void reset() {
    _creditsAccumulated = 0;
  }

  void removeAccumulated(double value) {
    _creditsAccumulated -= value;
  }

  void accumulate(double dt) {
    _creditsAccumulated += Constants.NODE_CREDITS_RATIO * dt;
  }
}
