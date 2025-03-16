enum UnitType {
  infantry(cost: 1, health: 100, attack: 10, range: 3);

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
