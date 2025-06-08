import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnCallable {
  Future call({
    required String matchId,
    required String selfId,
    required List<JsonAction> actions,
  }) => Backend.endTurn(matchId: matchId, selfId: selfId, actions: actions);
}
