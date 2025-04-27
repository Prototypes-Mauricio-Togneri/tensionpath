import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'turn')
  final int turn;

  @JsonKey(name: 'lastTurnStartedAt', toJson: dateToJson)
  final DateTime lastTurnStartedAt;

  @JsonKey(name: 'activePlayer')
  final String activePlayer;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  @JsonKey(name: 'config')
  final JsonConfig config;

  const JsonMatch({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.turn,
    required this.lastTurnStartedAt,
    required this.activePlayer,
    required this.players,
    required this.battlefield,
    required this.config,
  });

  JsonMatch withId(String id) => JsonMatch(
    id: id,
    version: version,
    createdAt: createdAt,
    turn: turn,
    lastTurnStartedAt: lastTurnStartedAt,
    activePlayer: activePlayer,
    players: players,
    battlefield: battlefield,
    config: config,
  );

  Match object(String selfId) {
    final Player self = _getSelf(selfId);
    final Player opponent = _getOpponent(selfId);

    return Match(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: turn,
      lastTurnStartedAt: lastTurnStartedAt,
      activePlayer: activePlayer,
      self: self,
      opponent: opponent,
      battlefield: battlefield.object([self, opponent]),
      config: config.object,
    );
  }

  Player _getSelf(String id) {
    for (final JsonPlayer player in players) {
      if (player.id == id) {
        return player.object(true);
      }
    }

    throw Exception('Player with id $id not found');
  }

  Player _getOpponent(String id) {
    for (final JsonPlayer player in players) {
      if (player.id != id) {
        return player.object(false);
      }
    }

    throw Exception('Player with id $id not found');
  }

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
