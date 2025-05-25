import 'package:tensionpath/domain/types/player_status.dart';

class Turn {
  int turn;
  DateTime startedAt;
  TurnPlayer player1;
  TurnPlayer player2;

  Turn({
    required this.turn,
    required this.startedAt,
    required this.player1,
    required this.player2,
  });

  void replaceWith(Turn newTurn) {
    turn = newTurn.turn;
    startedAt = newTurn.startedAt;
    player1 = newTurn.player1;
    player2 = newTurn.player2;
  }
}

class TurnPlayer {
  final PlayerStatus status;
  DateTime? turnEndedAt;

  TurnPlayer({required this.status, required this.turnEndedAt});
}
