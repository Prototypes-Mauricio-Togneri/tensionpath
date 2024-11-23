enum UnitType {
  melee1(
    cost: 1,
    health: 1,
    power: 1,
    speed: 151.2,
    range: -100,
  ),
  shooter2(
    cost: 2,
    health: 2,
    power: 2,
    speed: 151.2,
    range: 200,
  ),
  melee3(
    cost: 3,
    health: 3,
    power: 3,
    speed: 151.2,
    range: -100,
  ),
  shooter4(
    cost: 4,
    health: 4,
    power: 4,
    speed: 151.2,
    range: 300,
  ),
  melee5(
    cost: 5,
    health: 5,
    power: 5,
    speed: 151.2,
    range: -100,
  ),
  shooter6(
    cost: 6,
    health: 6,
    power: 6,
    speed: 151.2,
    range: 400,
  );

  final int cost;
  final int health;
  final int power;
  final double speed;
  final double range;

  const UnitType({
    required this.cost,
    required this.health,
    required this.power,
    required this.speed,
    required this.range,
  });
}
