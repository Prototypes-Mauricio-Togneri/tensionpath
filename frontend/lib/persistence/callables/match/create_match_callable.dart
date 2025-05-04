import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';

class CreateMatchCallable {
  Future call({required Room room}) async {
    final String content = await rootBundle.loadString(
      'assets/templates/w9h7.json',
    );
    JsonMatch jsonMatch = JsonMatch.fromJson(jsonDecode(content));
    jsonMatch = jsonMatch.clone(
      createdAt: DateTime.now(),
      turn: jsonMatch.turn.clone(startedAt: DateTime.now()),
    );
    final List<JsonPlayer> namedPlayers = [];

    for (final JsonPlayer jsonPlayer in jsonMatch.players) {
      namedPlayers.add(jsonPlayer.clone(name: room.players[jsonPlayer.id]));
    }

    final String matchId = await MatchRepository.create(
      jsonMatch.clone(players: namedPlayers),
    );

    final JsonRoom jsonRoom = JsonRoom(
      id: room.id,
      version: room.version,
      createdAt: room.createdAt,
      numberOfPlayers: room.numberOfPlayers,
      visibility: room.visibility,
      status: room.status,
      playerIds: room.playerIds,
      players: room.players,
      matchType: room.matchType,
      matchId: matchId,
    );
    await RoomRepository.update(jsonRoom);
  }
}
