import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnOpponentCallable {
  Future call({required String matchId, required String selfId}) =>
      Backend.endTurnOpponent(matchId: matchId, selfId: selfId);
}
