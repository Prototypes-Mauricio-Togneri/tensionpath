enum Priority {
  battlefield(0),
  structure(1),
  node(2),
  path(3),
  unit(4),
  shot(5),
  explosion(6),
  fog(7),
  header(8),
  controls(9);

  final int value;

  const Priority(this.value);
}
