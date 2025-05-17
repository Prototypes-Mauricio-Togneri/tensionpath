class Turn {
  int turn;
  DateTime startedAt;
  DateTime? player1EndedTurnAt;
  DateTime? player2EndedTurnAt;

  Turn({
    required this.turn,
    required this.startedAt,
    required this.player1EndedTurnAt,
    required this.player2EndedTurnAt,
  });

  void replaceWith(Turn newTurn) {
    turn = newTurn.turn;
    startedAt = newTurn.startedAt;
    player1EndedTurnAt = newTurn.player1EndedTurnAt;
    player2EndedTurnAt = newTurn.player2EndedTurnAt;
  }
}
