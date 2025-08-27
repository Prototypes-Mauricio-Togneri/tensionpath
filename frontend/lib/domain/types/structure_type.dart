enum StructureType {
  launcher(visibilityRange: 2, canMoveUnit: false),
  pad(visibilityRange: 0, canMoveUnit: true);

  final int visibilityRange;
  final bool canMoveUnit;

  const StructureType({
    required this.visibilityRange,
    required this.canMoveUnit,
  });
}
