import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';

class Matchmaking {
  Future<Room> call(String playerName) => RoomRepository.search(playerName);
}
