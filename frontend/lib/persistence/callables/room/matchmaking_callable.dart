import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class MatchmakingCallable {
  Future<MatchmakingInfo> call({
    required String userId,
    required String playerName,
  }) => Backend.matchmaking(userId: userId, playerName: playerName);
}
