enum NodeType {
  land,
  water,
  rock;

  bool get canMoveUnit {
    switch (this) {
      case NodeType.land:
        return true;
      case NodeType.water:
      case NodeType.rock:
        return false;
    }
  }

  const NodeType();
}
