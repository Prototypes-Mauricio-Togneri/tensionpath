class Config {
  final int resourcesPerPatch;
  final int resourcesPerTurn;
  final double resourcesPerSecond;
  final int popcap;

  const Config({
    required this.resourcesPerPatch,
    required this.resourcesPerTurn,
    required this.resourcesPerSecond,
    required this.popcap,
  });
}
