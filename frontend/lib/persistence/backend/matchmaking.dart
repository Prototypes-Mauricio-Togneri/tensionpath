import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';

class Matchmaking {
  Future<MatchmakingInfo> call({
    required String userId,
    required String playerName,
  }) => RoomRepository.getAvailableRoom(userId: userId, playerName: playerName);
}
