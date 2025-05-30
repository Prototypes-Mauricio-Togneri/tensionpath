import 'package:json_annotation/json_annotation.dart';

part 'json_room_player.g.dart';

@JsonSerializable()
class JsonRoomPlayer {
  @JsonKey(name: 'playerId')
  final String playerId;

  @JsonKey(name: 'name')
  final String name;

  const JsonRoomPlayer({required this.playerId, required this.name});

  factory JsonRoomPlayer.fromJson(Map<String, dynamic> json) =>
      _$JsonRoomPlayerFromJson(json);

  Map<String, dynamic> toJson() => _$JsonRoomPlayerToJson(this);
}
