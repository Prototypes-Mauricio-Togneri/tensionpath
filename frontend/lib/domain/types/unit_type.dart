enum UnitType {
  rifle_squad(cost: 1, health: 100, attack: 10, range: 3),
  sniper(cost: 1, health: 100, attack: 10, range: 3),
  humvee(cost: 1, health: 100, attack: 10, range: 3),
  tank(cost: 1, health: 100, attack: 10, range: 3),
  artillery(cost: 1, health: 100, attack: 10, range: 3),
  helicopter(cost: 1, health: 100, attack: 10, range: 3);

  final int cost;
  final double health;
  final double attack;
  final double range;

  const UnitType({
    required this.cost,
    required this.health,
    required this.attack,
    required this.range,
  });
}
