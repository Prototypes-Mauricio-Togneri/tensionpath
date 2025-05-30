import 'package:tensionpath/persistence/backend/backend.dart';

class MatchmakingCallable {
  Future<String> call({required String userId, required String playerName}) =>
      Backend.matchmaking(userId: userId, playerName: playerName);
}
