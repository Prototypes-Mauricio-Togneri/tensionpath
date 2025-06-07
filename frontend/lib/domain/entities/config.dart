class Config {
  final int popcap;
  final int baseMaxHealth;
  final int resourcesPerPatch;
  final int resourcesPerTurn;
  final double resourcesPerSecond;
  final double defenseFactor;

  const Config({
    required this.popcap,
    required this.baseMaxHealth,
    required this.resourcesPerPatch,
    required this.resourcesPerTurn,
    required this.resourcesPerSecond,
    required this.defenseFactor,
  });
}
