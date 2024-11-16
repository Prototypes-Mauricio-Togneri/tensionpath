enum Priority {
  battlefield(0),
  lane(1),
  node(2),
  unit(3),
  damage(4),
  base(5),
  controls(6);

  final int value;

  const Priority(this.value);
}
