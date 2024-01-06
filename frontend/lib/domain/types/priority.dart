enum Priority {
  battlefield(0),
  nodes(1),
  units(2),
  projectiles(3),
  damages(4);

  final int value;

  const Priority(this.value);
}
