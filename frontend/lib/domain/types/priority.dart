enum Priority {
  battlefield(0),
  structure(1),
  node(2),
  path(3),
  unit(4),
  shot(5),
  fog(6),
  header(7),
  controls(8);

  final int value;

  const Priority(this.value);
}
