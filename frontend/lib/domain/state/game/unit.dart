import 'package:flame/components.dart';

class Unit {
  final int power;
  final double speed;
  Vector2 position;

  Unit({
    required this.power,
    required this.speed,
    required this.position,
  });

  void update(double dt) {
    position.y -= speed * dt;
  }
}
