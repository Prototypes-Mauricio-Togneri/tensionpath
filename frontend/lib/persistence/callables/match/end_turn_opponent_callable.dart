import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnOpponentCallable {
  Future call({required Match match, required String selfId}) =>
      Backend.endTurnOpponent(match: match, selfId: selfId);
}
