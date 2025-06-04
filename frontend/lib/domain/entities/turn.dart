import 'package:tensionpath/utils/audio.dart';

class Turn {
  int turn;
  DateTime startedAt;

  Turn({required this.turn, required this.startedAt});

  void replaceWith(Turn newTurn) {
    if (turn != newTurn.turn) {
      Audio.get.playSound(Audio.NEW_TURN);
    }

    turn = newTurn.turn;
    startedAt = newTurn.startedAt;
  }
}
