import 'package:flame/components.dart';

class Unit {
  final int power;
  Vector2 position;

  Unit({
    required this.power,
    required this.position,
  });

  void update(double dt) {
    position -= Vector2(10 * dt, 10 * dt);
  }
}
