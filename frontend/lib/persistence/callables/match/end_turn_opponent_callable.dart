import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnOpponentCallable {
  Future call(Match match) => Backend.endTurnOpponent(match);
}
