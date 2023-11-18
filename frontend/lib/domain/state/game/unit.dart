import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/lane.dart';

class Unit {
  final int power;
  final double speed;
  Vector2 position;

  Unit._({
    required this.power,
    required this.speed,
    required this.position,
  });

  void update(double dt) {
    position.y -= speed * dt;
  }

  factory Unit.create({
    required int commandPoints,
    required Lane lane,
  }) =>
      Unit._(
        power: commandPoints,
        speed: 200,
        position: Vector2(lane.position.x + 100, 3000),
      );
}
