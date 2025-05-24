enum Priority {
  battlefield(0),
  node(1),
  structure(2),
  unit(3),
  fog(4),
  header(5),
  controls(6);

  final int value;

  const Priority(this.value);
}
