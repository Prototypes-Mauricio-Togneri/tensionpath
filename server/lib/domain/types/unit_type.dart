enum UnitType {
  harvester(
    cost: 60,
    maxHealth: 1000,
    speed: 3,
  ),
  infrantry(
    cost: 10,
    maxHealth: 300,
    speed: 5,
  ),
  vehicle(
    cost: 20,
    maxHealth: 300,
    speed: 4,
  ),
  aircraft(
    cost: 50,
    maxHealth: 150,
    speed: 6,
  );

  final int cost;
  final int maxHealth;
  final num speed;

  const UnitType({
    required this.cost,
    required this.maxHealth,
    required this.speed,
  });
}
