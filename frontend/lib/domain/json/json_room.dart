import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_room.g.dart';

@JsonSerializable()
class JsonRoom {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'numberOfPlayers')
  final int numberOfPlayers;

  @JsonKey(name: 'visibility')
  final RoomVisibility visibility;

  @JsonKey(name: 'status')
  final RoomStatus status;

  @JsonKey(name: 'playerIds')
  final List<String> playerIds;

  @JsonKey(name: 'players')
  final Map<String, String> players;

  @JsonKey(name: 'matchType')
  final String matchType;

  @JsonKey(name: 'matchId')
  final String? matchId;

  const JsonRoom({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.playerIds,
    required this.players,
    required this.matchType,
    required this.matchId,
  });

  JsonRoom clone({
    RoomStatus? status,
    List<String>? playerIds,
    Map<String, String>? players,
    String? matchId,
  }) => JsonRoom(
    id: id,
    version: version,
    createdAt: createdAt,
    numberOfPlayers: numberOfPlayers,
    visibility: visibility,
    matchType: matchType,
    status: status ?? this.status,
    playerIds: playerIds ?? this.playerIds,
    players: players ?? this.players,
    matchId: matchId ?? this.matchId,
  );

  Room get object => Room(
    id: id,
    version: version,
    createdAt: createdAt,
    numberOfPlayers: numberOfPlayers,
    visibility: visibility,
    status: status,
    playerIds: playerIds,
    players: players,
    matchType: matchType,
    matchId: matchId,
  );

  factory JsonRoom.fromJson(Map<String, dynamic> json) =>
      _$JsonRoomFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRoomToJson(this);
}
