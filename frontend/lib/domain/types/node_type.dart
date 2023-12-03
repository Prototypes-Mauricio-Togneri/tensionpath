enum NodeType {
  launcher(rate: 0.1),
  victory(rate: 0.01),
  chest(rate: 0.1),
  command_points_generator(rate: 0.1),
  unit_generator(rate: 0.1),
  checkpoint(rate: 0.1);

  final double rate;

  const NodeType({required this.rate});

  bool get isLauncher => this == launcher;

  bool get isVictory => this == victory;

  bool get isChest => this == chest;

  bool get isCommandPointsGenerator => this == command_points_generator;

  bool get isUnitGenerator => this == unit_generator;

  bool get isCheckpoint => this == checkpoint;

  bool get canAccumulate => isChest || isUnitGenerator;

  bool get canLaunch => isLauncher || isCheckpoint;

  bool get canBeCaptured =>
      isVictory || isCommandPointsGenerator || isUnitGenerator || isCheckpoint;
}
