import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/utils/json.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'status')
  final MatchStatus status;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'players')
  final Map<String, JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  @JsonKey(name: 'config')
  final JsonConfig config;

  @JsonKey(name: 'turn')
  final JsonTurn turn;

  @JsonKey(name: 'room')
  final JsonRoom room;

  JsonMatch({
    required this.id,
    required this.version,
    required this.status,
    required this.createdAt,
    required this.players,
    required this.battlefield,
    required this.config,
    required this.turn,
    required this.room,
  });

  Match object(String userId) {
    final Player self = _getSelf(userId);
    final Player opponent = _getOpponent(userId);

    return Match(
      id: id,
      version: version,
      status: status,
      createdAt: createdAt,
      self: self,
      opponent: opponent,
      battlefield: battlefield.object([self, opponent]),
      config: config.object,
      turn: turn.object,
      room: room.object,
    );
  }

  Player _getSelf(String userId) {
    for (final JsonPlayer json in players.values) {
      if (json.userId == userId) {
        return json.object(userId);
      }
    }

    throw Exception('Player with user ID $userId not found');
  }

  Player _getOpponent(String userId) {
    for (final JsonPlayer json in players.values) {
      if (json.userId != userId) {
        return json.object(userId);
      }
    }

    throw Exception('Player with user ID $userId not found');
  }

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
