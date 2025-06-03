class Missile {
  final int maxCharge;
  final int bufferCharge;
  final int numberOfPlatforms;
  int charge;
  Map<String, String?> platforms;
  String? owner;

  Missile({
    required this.charge,
    required this.maxCharge,
    required this.bufferCharge,
    required this.numberOfPlatforms,
    required this.platforms,
  });

  void replaceWith(Missile newMissile) {
    charge = newMissile.charge;
    platforms = newMissile.platforms;
    owner = newMissile.owner;
  }

  String? platformOwner(String platformId) => platforms[platformId];
}
