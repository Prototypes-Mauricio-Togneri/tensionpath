import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_config.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_turn.dart';
import 'package:tensionpath/persistence/backend/json_utils.dart';

part 'json_match.g.dart';

@JsonSerializable()
class JsonMatch {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'version')
  final int version;

  @JsonKey(name: 'createdAt', toJson: dateToJson)
  final DateTime createdAt;

  @JsonKey(name: 'players')
  final List<JsonPlayer> players;

  @JsonKey(name: 'battlefield')
  final JsonBattlefield battlefield;

  @JsonKey(name: 'config')
  final JsonConfig config;

  @JsonKey(name: 'turn')
  final JsonTurn turn;

  const JsonMatch({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.players,
    required this.battlefield,
    required this.config,
    required this.turn,
  });

  JsonMatch clone({
    String? id,
    DateTime? createdAt,
    JsonTurn? turn,
    List<JsonPlayer>? players,
  }) => JsonMatch(
    id: id ?? this.id,
    version: version,
    createdAt: createdAt ?? this.createdAt,
    players: players ?? this.players,
    battlefield: battlefield,
    config: config,
    turn: turn ?? this.turn,
  );

  Match object(String selfId) {
    final Player self = _getSelf(selfId);
    final Player opponent = _getOpponent(selfId);

    return Match(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: turn.object,
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

  static Future<JsonMatch> fromTemplate(String template) async {
    final String content = await rootBundle.loadString(
      'assets/templates/w5h7.json',
    );
    return JsonMatch.fromJson(jsonDecode(content));
  }

  Map<String, dynamic> toJson() => _$JsonMatchToJson(this);
}
