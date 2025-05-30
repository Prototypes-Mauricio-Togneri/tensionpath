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
  final Map<String, RoomPlayer> players;
  final String matchType;
  final String? matchId;

  const Room({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.players,
    required this.matchType,
    required this.matchId,
  });

  String get playerId => players[Authentication.userId]?.playerId ?? '';

  bool get isReady => (players.length >= numberOfPlayers) && (matchId != null);
}

class RoomPlayer {
  final String playerId;
  final String name;

  const RoomPlayer({required this.playerId, required this.name});
}
