import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/persistence/backend/backend.dart';

class MatchmakingCallable {
  Future<MatchmakingInfo> call(String playerName) =>
      Backend.matchmaking(playerName);
}
