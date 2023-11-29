enum NodeType {
  victory,
  chest,
  command_point_generator,
  unit_generator,
  checkpoint;

  bool get isChest => this == chest;

  bool get canAccumulate => (this == chest) || (this == unit_generator);
}
