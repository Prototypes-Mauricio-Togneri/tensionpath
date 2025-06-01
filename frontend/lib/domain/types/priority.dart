enum Priority {
  battlefield(0),
  node(1),
  structure(2),
  unit(3),
  actions(4),
  fog(5),
  header(6),
  controls(7);

  final int value;

  const Priority(this.value);
}
