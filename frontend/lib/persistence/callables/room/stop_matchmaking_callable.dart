import 'package:tensionpath/persistence/backend/backend.dart';

class StopMatchmakingCallable {
  Future call({required String userId, required String roomId}) =>
      Backend.stopMatchmaking(userId: userId, roomId: roomId);
}
