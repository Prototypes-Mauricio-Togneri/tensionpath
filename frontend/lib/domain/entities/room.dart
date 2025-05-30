import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/utils/authentication.dart';

class Room {
  final String id;
  final int version;
  final DateTime createdAt;
  final int numberOfPlayers;
  final RoomVisibility visibility;
  final RoomStatus status;
  final List<String> userIds;
  final Map<String, String> users;
  final String matchType;
  final String? matchId;

  const Room({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.userIds,
    required this.users,
    required this.matchType,
    required this.matchId,
  });

  String get playerId {
    for (int i = 0; i < userIds.length; i++) {
      if (userIds[i] == Authentication.userId) {
        return (i + 1).toString();
      }
    }

    throw Exception('User not found in room');
  }

  bool get isReady => (users.length >= numberOfPlayers) && (matchId != null);
}
