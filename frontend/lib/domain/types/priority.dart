enum Priority {
  battlefield(0),
  structure(1),
  unit(2),
  fog(3),
  damage(4),
  header(5),
  controls(6);

  final int value;

  const Priority(this.value);
}
