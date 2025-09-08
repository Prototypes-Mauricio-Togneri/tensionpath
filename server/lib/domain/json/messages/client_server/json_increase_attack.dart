import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_increase_attack.g.dart';

@JsonSerializable()
class JsonIncreaseAttack {
  @JsonKey(name: 'roomId')
  final String roomId;

  const JsonIncreaseAttack({
    required this.roomId,
  });

  factory JsonIncreaseAttack.fromString(String json) =>
      JsonIncreaseAttack.fromJson(jsonDecode(json));

  factory JsonIncreaseAttack.fromJson(Map<String, dynamic> json) =>
      _$JsonIncreaseAttackFromJson(json);

  Map<String, dynamic> toJson() => _$JsonIncreaseAttackToJson(this);
}
