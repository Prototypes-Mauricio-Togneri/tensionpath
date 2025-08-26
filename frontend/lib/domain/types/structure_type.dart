enum StructureType {
  resources(visibilityRange: 0, canMoveUnit: true),
  launcher(visibilityRange: 2, canMoveUnit: false),
  missile(visibilityRange: 0, canMoveUnit: false),
  pad(visibilityRange: 0, canMoveUnit: true);

  final int visibilityRange;
  final bool canMoveUnit;

  const StructureType({
    required this.visibilityRange,
    required this.canMoveUnit,
  });
}
