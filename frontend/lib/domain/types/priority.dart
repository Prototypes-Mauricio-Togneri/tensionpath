enum Priority {
  battlefield(0),
  lane(1),
  base(2),
  node(3),
  unit(4),
  damage(5),
  controls(6);

  final int value;

  const Priority(this.value);
}
