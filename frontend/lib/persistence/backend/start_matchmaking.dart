import 'package:tensionpath/persistence/repository/room_repository.dart';

class StartMatchmaking {
  Future<String> call({required String userId, required String playerName}) =>
      RoomRepository.startMatchmaking(userId: userId, playerName: playerName);
}
