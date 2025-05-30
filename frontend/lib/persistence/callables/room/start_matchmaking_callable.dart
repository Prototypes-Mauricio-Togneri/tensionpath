import 'package:tensionpath/persistence/backend/backend.dart';

class StartMatchmakingCallable {
  Future<String> call({required String userId, required String playerName}) =>
      Backend.startMatchmaking(userId: userId, playerName: playerName);
}
