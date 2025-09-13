enum UnitType {
  unit_10(
    cost: 10,
    power: 10,
    visibility: 1,
    speed: 0.5,
  ),
  unit_20(
    cost: 20,
    power: 22,
    visibility: 1,
    speed: 0.5,
  ),
  unit_30(
    cost: 30,
    power: 34,
    visibility: 1,
    speed: 0.5,
  ),
  unit_40(
    cost: 40,
    power: 46,
    visibility: 1,
    speed: 0.5,
  ),
  unit_50(
    cost: 50,
    power: 58,
    visibility: 1,
    speed: 0.5,
  ),
  unit_60(
    cost: 60,
    power: 70,
    visibility: 1,
    speed: 0.5,
  );

  final int cost;
  final int power;
  final int visibility;
  final double speed;

  const UnitType({
    required this.cost,
    required this.power,
    required this.visibility,
    required this.speed,
  });
}
