class Player {
  final String id;
  final String name;
  final String index;
  final int baseMaxHealth;
  int baseHealth;
  double resources;

  Player({
    required this.id,
    required this.name,
    required this.index,
    required this.baseMaxHealth,
    required this.baseHealth,
    required this.resources,
  });
}
