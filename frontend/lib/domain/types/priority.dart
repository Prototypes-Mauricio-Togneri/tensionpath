enum Priority {
  battlefield(0),
  node(1),
  unit(2),
  damage(3),
  controls(4);

  final int value;

  const Priority(this.value);
}
