enum NodeType {
  empty,
  resources,
  launcher,
  pad;

  static List<NodeType> get canMove => [
    empty,
    resources,
    pad,
  ];
}
