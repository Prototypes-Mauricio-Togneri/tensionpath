import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'json_join_battle.g.dart';

@JsonSerializable()
class JsonJoinBattle {
  @JsonKey(name: 'battleId')
  final String battleId;

  @JsonKey(name: 'playerId')
  final String playerId;

  const JsonJoinBattle({
    required this.battleId,
    required this.playerId,
  });

  factory JsonJoinBattle.fromString(String json) =>
      JsonJoinBattle.fromJson(jsonDecode(json));

  factory JsonJoinBattle.fromJson(Map<String, dynamic> json) =>
      _$JsonJoinBattleFromJson(json);

  Map<String, dynamic> toJson() => _$JsonJoinBattleToJson(this);
}
