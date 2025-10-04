enum NodeType {
  empty,
  resources,
  launcher,
  pad,
  water,
  missile;

  bool get canMove => [
    empty,
    resources,
    pad,
  ].contains(this);
}
