import 'dart:async';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/persistence/backend/end_turn.dart';
import 'package:tensionpath/persistence/backend/surrender.dart';

class Backend {
  static Future endTurn({
    required String matchId,
    required String selfId,
    required List<JsonAction> actions,
  }) => EndTurn()(matchId: matchId, selfId: selfId, actions: actions);

  static Future surrender({required String matchId, required String selfId}) =>
      Surrender()(matchId: matchId, selfId: selfId);
}
