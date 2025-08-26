import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  const JsonMatch({
    required this.id,
    required this.createdAt,
    required this.players,
    required this.battlefield,
  });

  JsonMatch clone({
    String? id,
    DateTime? createdAt,
    List<JsonPlayer>? players,
  }) => JsonMatch(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    players: players ?? this.players,
    battlefield: battlefield,
  );

  Match object(String selfId) {
    final Player self = _getSelf(selfId);
    final Player opponent = _getOpponent(selfId);

    return Match(
      id: id,
      createdAt: createdAt,
      self: self,
      opponent: opponent,
      battlefield: battlefield.object([self, opponent]),
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
