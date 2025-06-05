import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/utils/json.dart';

part 'json_room.g.dart';

@JsonSerializable()
class JsonRoom {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'version')
  int version;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  DateTime createdAt;

  @JsonKey(name: 'numberOfPlayers')
  int numberOfPlayers;

  @JsonKey(name: 'visibility')
  RoomVisibility visibility;

  @JsonKey(name: 'status')
  RoomStatus status;

  @JsonKey(name: 'userIds')
  List<String> userIds;

  @JsonKey(name: 'users')
  Map<String, String> users;

  @JsonKey(name: 'matchType')
  String matchType;

  @JsonKey(name: 'matchId')
  String? matchId;

  JsonRoom({
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
