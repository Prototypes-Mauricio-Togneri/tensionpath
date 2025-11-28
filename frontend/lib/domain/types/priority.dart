enum Priority {
  battlefield(0),
  structure(1),
  node(2),
  path(3),
  unit(4),
  shot(5),
  explosion(6),
  reward(7),
  missile(8),
  fog(9),
  header(10),
  controls(11)
  ;

  final int value;

  const Priority(this.value);
}
