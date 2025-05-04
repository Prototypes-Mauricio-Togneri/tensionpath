import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/persistence/repository/room_repository.dart';
import 'package:tensionpath/utils/assets.dart';

class CreateMatchCallable {
  Future call({required Room room}) async {
    final String content = await rootBundle.loadString(Assets.TEMPLATES_W9H7);
    final JsonMatch jsonMatch = JsonMatch.fromJson(jsonDecode(content));
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
    await RoomRepository.update(json: jsonRoom);
  }
}
