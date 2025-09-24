enum UnitType {
  harvester(
    cost: 60,
    health: 1000,
    speed: 3,
    damage: 0,
    attackCooldown: 0,
  ),
  plant_1(
    cost: 10,
    health: 300,
    speed: 5,
    damage: 20,
    attackCooldown: 1,
  ),
  plant_2(
    cost: 20,
    health: 300,
    speed: 4,
    damage: 30,
    attackCooldown: 1.5,
  ),
  plant_3(
    cost: 50,
    health: 150,
    speed: 6,
    damage: 40,
    attackCooldown: 2,
  ),
  water_1(
    cost: 10,
    health: 300,
    speed: 5,
    damage: 20,
    attackCooldown: 1,
  ),
  water_2(
    cost: 20,
    health: 300,
    speed: 4,
    damage: 30,
    attackCooldown: 1.5,
  ),
  water_3(
    cost: 50,
    health: 150,
    speed: 6,
    damage: 40,
    attackCooldown: 2,
  ),
  fire_1(
    cost: 10,
    health: 300,
    speed: 5,
    damage: 20,
    attackCooldown: 1,
  ),
  fire_2(
    cost: 20,
    health: 300,
    speed: 4,
    damage: 30,
    attackCooldown: 1.5,
  ),
  fire_3(
    cost: 50,
    health: 150,
    speed: 6,
    damage: 40,
    attackCooldown: 2,
  );

  final int cost;
  final int health;
  final num speed;
  final num damage;
  final num attackCooldown;

  const UnitType({
    required this.cost,
    required this.health,
    required this.speed,
    required this.damage,
    required this.attackCooldown,
  });
}
