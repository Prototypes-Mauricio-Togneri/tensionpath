enum NodeType {
  victory,
  chest,
  command_point_generator,
  unit_generator,
  checkpoint;

  bool get canAccumulate =>
      (this == command_point_generator) || (this == unit_generator);
}
