enum BuildingType {
  main(cost: 0),
  barracks(cost: 30),
  factory(cost: 40),
  airfield(cost: 50),
  tech(cost: 100)
  ;

  final int cost;

  const BuildingType({required this.cost});

  static List<BuildingType> get buildings => [
    barracks,
    factory,
    airfield,
    tech,
  ];
}
