enum Priority {
  battlefield(0),
  node(1),
  unit(2),
  projectile(3),
  damage(4);

  final int value;

  const Priority(this.value);
}
