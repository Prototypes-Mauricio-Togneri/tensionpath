import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnSelfCallable {
  Future call({
    required String matchId,
    required String selfId,
    required List<JsonAction> actions,
  }) => Backend.endTurnSelf(matchId: matchId, selfId: selfId, actions: actions);
}
