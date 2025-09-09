import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_increase_attack.g.dart';

@JsonSerializable()
class JsonIncreaseAttack {
  @JsonKey(name: 'battleId')
  final String battleId;

  const JsonIncreaseAttack({
    required this.battleId,
  });

  factory JsonIncreaseAttack.fromString(String json) =>
      JsonIncreaseAttack.fromJson(jsonDecode(json));

  factory JsonIncreaseAttack.fromJson(Map<String, dynamic> json) =>
      _$JsonIncreaseAttackFromJson(json);

  Map<String, dynamic> toJson() => _$JsonIncreaseAttackToJson(this);
}
