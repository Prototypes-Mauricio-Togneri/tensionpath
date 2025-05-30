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

  @JsonKey(name: 'userIds')
  final List<String> userIds;

  @JsonKey(name: 'users')
  final Map<String, String> users;

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
    required this.userIds,
    required this.users,
    required this.matchType,
    required this.matchId,
  });

  JsonRoom clone({
    RoomStatus? status,
    List<String>? userIds,
    Map<String, String>? users,
    String? matchId,
  }) => JsonRoom(
    id: id,
    version: version,
    createdAt: createdAt,
    numberOfPlayers: numberOfPlayers,
    visibility: visibility,
    matchType: matchType,
    userIds: userIds ?? this.userIds,
    status: status ?? this.status,
    users: users ?? this.users,
    matchId: matchId ?? this.matchId,
  );

  Room get object => Room(
    id: id,
    version: version,
    createdAt: createdAt,
    numberOfPlayers: numberOfPlayers,
    visibility: visibility,
    status: status,
    userIds: userIds,
    users: users,
    matchType: matchType,
    matchId: matchId,
  );

  Map<String, String> get playersMap {
    final Map<String, String> result = {};

    for (int i = 0; i < userIds.length; i++) {
      final String playerId = (i + 1).toString();
      final String playerName = users[userIds[i]]!;

      result[playerId] = playerName;
    }

    return result;
  }

  factory JsonRoom.fromJson(Map<String, dynamic> json) =>
      _$JsonRoomFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRoomToJson(this);
}
