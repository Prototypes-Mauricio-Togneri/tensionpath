import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_increase_mine.g.dart';

@JsonSerializable()
class JsonIncreaseMine {
  @JsonKey(name: 'roomId')
  final String roomId;

  const JsonIncreaseMine({
    required this.roomId,
  });

  factory JsonIncreaseMine.fromString(String json) =>
      JsonIncreaseMine.fromJson(jsonDecode(json));

  factory JsonIncreaseMine.fromJson(Map<String, dynamic> json) =>
      _$JsonIncreaseMineFromJson(json);

  Map<String, dynamic> toJson() => _$JsonIncreaseMineToJson(this);
}
