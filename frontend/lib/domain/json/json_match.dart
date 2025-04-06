import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
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

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  const JsonMatch({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.turn,
    required this.activePlayer,
    required this.players,
    required this.battlefield,
  });

  Match get object {
    final Player self = players[0].object(true);
    final Player opponent = players[1].object(false);

    return Match(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: turn,
      activePlayer: activePlayer,
      self: self,
      opponent: opponent,
      battlefield: battlefield.object([self, opponent]),
    );
  }

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
