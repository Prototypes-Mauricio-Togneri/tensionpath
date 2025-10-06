import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/models/room/json_user.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';

part 'json_room.g.dart';

@JsonSerializable()
class JsonRoom {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'numberOfPlayers')
  final int numberOfPlayers;

  @JsonKey(name: 'visibility')
  final RoomVisibility visibility;

  @JsonKey(name: 'status')
  final RoomStatus status;

  @JsonKey(name: 'matchType')
  final String matchType;

  final Map<String, JsonUser> users;

  @JsonKey(name: 'matchId')
  final String? matchId;

  @JsonKey(name: 'matchHost')
  final String? matchHost;

  const JsonRoom({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.visibility,
    required this.status,
    required this.matchType,
    required this.users,
    required this.matchId,
    required this.matchHost,
  });

  Room get object => Room(
    id: id,
    version: version,
    createdAt: DateTime.parse(createdAt).toLocal(),
    numberOfPlayers: numberOfPlayers,
    visibility: visibility,
    status: status,
    users: users.map((key, value) => MapEntry(key, value.object)),
    matchType: matchType,
    matchId: matchId,
    matchHost: matchHost,
  );

  factory JsonRoom.fromJson(Map<String, dynamic> json) =>
      _$JsonRoomFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRoomToJson(this);
}
