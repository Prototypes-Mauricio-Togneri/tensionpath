import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class EndTurnSelfCallable {
  Future call({required Match match, required String selfId}) =>
      Backend.endTurnSelf(match: match, selfId: selfId);
}
