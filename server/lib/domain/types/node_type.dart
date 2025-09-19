enum NodeType {
  empty,
  resources,
  launcher,
  pad,
  missile;

  static List<NodeType> get canMove => [
    empty,
    resources,
    pad,
  ];
}
