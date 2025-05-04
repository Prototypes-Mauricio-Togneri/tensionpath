import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';

class Room {
  final String id;
  final int version;
  final DateTime createdAt;
  final int numberOfPlayers;
  final RoomVisibility visibility;
  final RoomStatus status;
  final String matchType;
  final List<String> playerIds;
  final Map<String, String> players;

  const Room({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.matchType,
    required this.playerIds,
    required this.players,
  });

  bool get isFull => playerIds.length >= numberOfPlayers;
}
