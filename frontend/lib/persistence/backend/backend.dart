import 'dart:async';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/backend/end_turn.dart';

class Backend {
  static Future endTurn({
    required String matchId,
    required String selfId,
    required List<JsonAction> actions,
  }) => EndTurn()(matchId: matchId, selfId: selfId, actions: actions);
}
