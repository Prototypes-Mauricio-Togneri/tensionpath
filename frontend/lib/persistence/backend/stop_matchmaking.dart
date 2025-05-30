import 'package:tensionpath/persistence/repository/room_repository.dart';

class StopMatchmaking {
  Future call({required String userId, required String roomId}) =>
      RoomRepository.stopMatchmaking(userId: userId, roomId: roomId);
}
