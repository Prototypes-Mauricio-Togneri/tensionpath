import 'package:json_annotation/json_annotation.dart';

part 'json_create_battle.g.dart';

@JsonSerializable()
class JsonCreateBattle {
  @JsonKey(name: 'battleId')
  final String battleId;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'numberOfPlayers')
  final int numberOfPlayers;

  @JsonKey(name: 'matchType')
  final String matchType;

  @JsonKey(name: 'players')
  final Map<String, String> players;

  const JsonCreateBattle({
    required this.battleId,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.players,
  });

  factory JsonCreateBattle.fromJson(Map<String, dynamic> json) =>
      _$JsonCreateBattleFromJson(json);

  Map<String, dynamic> toJson() => _$JsonCreateBattleToJson(this);
}
