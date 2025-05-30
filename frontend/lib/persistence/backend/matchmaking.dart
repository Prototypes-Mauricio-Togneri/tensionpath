import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';

class Matchmaking {
  Future<MatchmakingInfo> call(String playerName) => RoomRepository.search(playerName);
}
