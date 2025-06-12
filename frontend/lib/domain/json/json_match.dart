import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/domain/types/match_status.dart';
import 'package:tensionpath/utils/json.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'version')
  int version;

  @JsonKey(name: 'status')
  MatchStatus status;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  DateTime createdAt;

  @JsonKey(name: 'players')
  Map<String, JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  JsonBattlefield battlefield;

  @JsonKey(name: 'config')
  JsonConfig config;

  @JsonKey(name: 'turn')
  JsonTurn turn;

  JsonMatch({
    required this.id,
    required this.version,
    required this.status,
    required this.createdAt,
    required this.players,
    required this.battlefield,
    required this.config,
    required this.turn,
  });

  Match object(String selfId) {
    final Player self = _getSelf(selfId);
    final Player opponent = _getOpponent(selfId);

    return Match(
      id: id,
      version: version,
      status: status,
      createdAt: createdAt,
      turn: turn.object,
      self: self,
      opponent: opponent,
      battlefield: battlefield.object([self, opponent]),
      config: config.object,
    );
  }

  Player _getSelf(String selfId) {
    for (final MapEntry<String, JsonPlayer> entry in players.entries) {
      if (entry.key == selfId) {
        return entry.value.object(id: entry.key, isSelf: true);
      }
    }

    throw Exception('Player with id $selfId not found');
  }

  Player _getOpponent(String selfId) {
    for (final MapEntry<String, JsonPlayer> entry in players.entries) {
      if (entry.key != selfId) {
        return entry.value.object(id: entry.key, isSelf: false);
      }
    }

    throw Exception('Player with id $selfId not found');
  }

  factory JsonMatch.fromJson(Map<String, dynamic> json) =>
      _$JsonMatchFromJson(json);

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
