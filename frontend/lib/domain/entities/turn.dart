class Turn {
  int turn;
  DateTime startedAt;

  Turn({required this.turn, required this.startedAt});

  void replaceWith(Turn newTurn) {
    turn = newTurn.turn;
    startedAt = newTurn.startedAt;
  }
}
