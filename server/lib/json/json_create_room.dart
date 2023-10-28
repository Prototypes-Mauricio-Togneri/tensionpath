import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_create_room.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonCreateRoom {
  @JsonKey(name: 'roomId')
  final String roomId;

  const JsonCreateRoom({
    required this.roomId,
  });

  factory JsonCreateRoom.fromString(String json) =>
      JsonCreateRoom.fromJson(jsonDecode(json));

  factory JsonCreateRoom.fromJson(Map<String, dynamic> json) =>
      _$JsonCreateRoomFromJson(json);

  Map<String, dynamic> toJson() => _$JsonCreateRoomToJson(this);
}
