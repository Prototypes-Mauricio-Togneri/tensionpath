enum StructureType {
  resources(visibilityRange: 0),
  launcher(visibilityRange: 2),
  missile(visibilityRange: 0),
  platform(visibilityRange: 0);

  final int visibilityRange;

  const StructureType({required this.visibilityRange});
}
