import 'package:tensionpath/persistence/backend/backend.dart';

class SurrenderCallable {
  Future call({required String matchId, required String selfId}) =>
      Backend.surrender(matchId: matchId, selfId: selfId);
}
