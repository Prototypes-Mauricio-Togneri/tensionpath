enum NodeType {
  launcher,
  victory,
  chest,
  command_points_generator,
  unit_generator,
  checkpoint;

  bool get isLauncher => this == launcher;

  bool get isVictory => this == victory;

  bool get isChest => this == chest;

  bool get isCommandPointsGenerator => this == command_points_generator;

  bool get isUnitGenerator => this == unit_generator;

  bool get isCheckpoint => this == checkpoint;

  bool get canAccumulate => (this == chest) || (this == unit_generator);

  bool get canBeCaptured =>
      isVictory || isCommandPointsGenerator || isUnitGenerator || isCheckpoint;
}
