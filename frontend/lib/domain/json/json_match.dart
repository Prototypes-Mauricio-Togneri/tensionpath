import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_player.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'activePlayer')
  final String activePlayer;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  const JsonMatch({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.turn,
    required this.activePlayer,
    required this.players,
  });

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Player get self => players[0].player(true);

  Player get opponent => players[1].player(true);
}
