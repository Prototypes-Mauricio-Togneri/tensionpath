import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionbase/json/json_join_room.dart';

part 'json_message.g.dart';

@JsonSerializable(includeIfNull: false)
class JsonMessage {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'payload')
  final dynamic payload;

  const JsonMessage({
    required this.type,
    this.payload,
  });

  dynamic get message {
    if (type == 'JOIN') {
      return JsonJoinRoom.fromJson(payload);
    } else {
      throw Exception('Invalid type: $type');
    }
  }

  factory JsonMessage.fromString(String json) =>
      JsonMessage.fromJson(jsonDecode(json));

  factory JsonMessage.fromJson(Map<String, dynamic> json) =>
      _$JsonMessageFromJson(json);

  factory JsonMessage.welcome() => const JsonMessage(type: 'WELCOME');

  factory JsonMessage.error(String message) => JsonMessage(
        type: 'ERROR',
        payload: message,
      );

  Map<String, dynamic> toJson() => _$JsonMessageToJson(this);

  @override
  String toString() => jsonEncode(toJson());
}
