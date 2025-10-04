enum NodeType {
  empty(canMove: true),
  resources(canMove: true),
  launcher(canMove: false),
  pad(canMove: true),
  rocks_low(canMove: false),
  missile(canMove: false);

  final bool canMove;

  const NodeType({
    required this.canMove,
  });
}
