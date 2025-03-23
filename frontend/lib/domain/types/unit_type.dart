enum UnitType {
  rifle_squad(cost: 1, health: 100, attack: 10, range: 3),
  sniper(cost: 2, health: 100, attack: 10, range: 3),
  humvee(cost: 3, health: 100, attack: 10, range: 3),
  tank(cost: 4, health: 100, attack: 10, range: 3),
  artillery(cost: 5, health: 100, attack: 10, range: 3),
  helicopter(cost: 6, health: 100, attack: 10, range: 3);

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
