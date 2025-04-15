enum Priority {
  battlefield(0),
  node(1),
  structure(2),
  unit(3),
  fog(4),
  damage(5),
  header(6),
  controls(7);

  final int value;

  const Priority(this.value);
}
