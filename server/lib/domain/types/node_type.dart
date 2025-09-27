enum NodeType {
  empty,
  resources,
  launcher,
  pad,
  missile;

  bool get canMove => [
    empty,
    resources,
    pad,
  ].contains(this);
}
