enum StructureType {
  obstacle(visibilityRange: 0, isObstacle: true),
  resources(visibilityRange: 0, isObstacle: false),
  launcher(visibilityRange: 2, isObstacle: false),
  missile(visibilityRange: 0, isObstacle: true),
  pad(visibilityRange: 0, isObstacle: false);

  final int visibilityRange;
  final bool isObstacle;

  const StructureType({
    required this.visibilityRange,
    required this.isObstacle,
  });
}
