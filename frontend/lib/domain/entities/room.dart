import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';

class Room {
  final String id;
  final int version;
  final DateTime createdAt;
  final int numberOfPlayers;
  final RoomVisibility visibility;
  final RoomStatus status;
  final Map<String, String> users;
  final String matchType;
  final String? matchId;
  final String? matchHost;

  const Room({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.users,
    required this.matchType,
    required this.matchId,
    required this.matchHost,
  });

  bool get isReady => (users.length >= numberOfPlayers) && (matchId != null);
}
