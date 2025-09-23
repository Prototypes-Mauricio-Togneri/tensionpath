enum UnitType {
  harvester(
    cost: 60,
    health: 1000,
    speed: 3,
    attack: 0,
    attackCooldown: 0,
  ),
  infrantry(
    cost: 10,
    health: 300,
    speed: 5,
    attack: 20,
    attackCooldown: 1,
  ),
  vehicle(
    cost: 20,
    health: 300,
    speed: 4,
    attack: 30,
    attackCooldown: 1.5,
  ),
  aircraft(
    cost: 50,
    health: 150,
    speed: 6,
    attack: 40,
    attackCooldown: 2,
  );

  final int cost;
  final int health;
  final num speed;
  final num attack;
  final num attackCooldown;

  const UnitType({
    required this.cost,
    required this.health,
    required this.speed,
    required this.attack,
    required this.attackCooldown,
  });
}
