enum UnitType {
  harvester(
    cost: 60,
    maxHealth: 1000,
    speed: 0.3,
  ),
  infrantry(
    cost: 10,
    maxHealth: 300,
    speed: 0.5,
  ),
  vehicle(
    cost: 20,
    maxHealth: 300,
    speed: 0.4,
  ),
  aircraft(
    cost: 50,
    maxHealth: 150,
    speed: 0.6,
  );

  final int cost;
  final int maxHealth;
  final double speed;

  const UnitType({
    required this.cost,
    required this.maxHealth,
    required this.speed,
  });
}
