import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnSelfCallable {
  Future call(Match match) => Backend.endTurn(match);
}
