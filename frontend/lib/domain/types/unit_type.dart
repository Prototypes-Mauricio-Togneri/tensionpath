enum UnitType {
  melee1(cost: 1),
  shooter2(cost: 2),
  melee3(cost: 3),
  shooter4(cost: 4),
  melee5(cost: 5),
  shooter6(cost: 6);

  final int cost;

  const UnitType({required this.cost});
}
