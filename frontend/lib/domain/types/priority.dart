enum Priority {
  battlefield(0),
  structure(1),
  node(2),
  path(3),
  unit(4),
  shot(5),
  explosion(6),
  missile(7),
  fog(8),
  header(9),
  controls(10);

  final int value;

  const Priority(this.value);
}
