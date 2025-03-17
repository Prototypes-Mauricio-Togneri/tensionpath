enum Priority {
  battlefield(0),
  node(1),
  unit(2),
  damage(3),
  header(4),
  controls(5);

  final int value;

  const Priority(this.value);
}
