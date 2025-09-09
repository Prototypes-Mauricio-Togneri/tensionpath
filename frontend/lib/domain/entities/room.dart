import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';

class Room {
  final String id;
  final int version;
  final DateTime createdAt;
  final int numberOfPlayers;
  final RoomVisibility visibility;
  final RoomStatus status;
  final String playerId;
  final Map<String, String> players;
  final String matchType;
  final String? matchId;

  const Room({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.playerId,
    required this.players,
    required this.matchType,
    required this.matchId,
  });

  bool get isFull => players.length >= numberOfPlayers;

  bool get hasMatchId => matchId != null;
}
