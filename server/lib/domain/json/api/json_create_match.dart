import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/json/api/json_player.dart';

part 'json_create_match.g.dart';

@JsonSerializable()
class JsonCreateMatch {
  @JsonKey(name: 'matchId')
  final String matchId;

  @JsonKey(name: 'mapId')
  final String mapId;

  @JsonKey(name: 'createdAt')
  final DateTime createdAt;

  @JsonKey(name: 'numberOfPlayers')
  final int numberOfPlayers;

  @JsonKey(name: 'matchType')
  final String matchType;

  @JsonKey(name: 'playerIds')
  final List<String> playerIds;

  @JsonKey(name: 'players')
  final Map<String, JsonPlayer> players;

  const JsonCreateMatch({
    required this.matchId,
    required this.mapId,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.playerIds,
    required this.players,
  });

  factory JsonCreateMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonCreateMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonCreateMatchToJson(this);
}
