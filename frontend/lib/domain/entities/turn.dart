class Turn {
  int turn;
  DateTime startedAt;
  String player;

  Turn({required this.turn, required this.startedAt, required this.player});

  void replaceWith(Turn newTurn) {
    turn = newTurn.turn;
    startedAt = newTurn.startedAt;
    player = newTurn.player;
  }
}
