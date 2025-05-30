import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/error_handler.dart';
import 'package:tensionpath/utils/id.dart';

class RoomRepository {
  static DocumentReference _ref([String? roomId]) =>
      FirebaseFirestore.instance.collection('rooms').doc(roomId);

  static Future<Room> search(String playerName) async {
    final CollectionReference ref = FirebaseFirestore.instance.collection(
      'rooms',
    );

    final Query query = ref
        .where('numberOfPlayers', isEqualTo: 2)
        .where('visibility', isEqualTo: RoomVisibility.public.name)
        .where('status', isEqualTo: RoomStatus.open.name)
        .where('matchType', isEqualTo: '1v1');

    final QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return _createRoom(playerName);
    } else {
      return _joinRoom(playerName: playerName, doc: snapshot.docs.first);
    }
  }

  static Future<Room> _createRoom(String playerName) async {
    final DocumentReference ref = _ref();
    final JsonRoom json = JsonRoom(
      id: ref.id,
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      playerIds: [Constants.PLAYER_1],
      players: {Constants.PLAYER_1: playerName},
      matchId: null,
    );
    await ref.set(json.toJson());

    return json.object;
  }

  static Future<Room> _joinRoom({
    required String playerName,
    required DocumentSnapshot doc,
  }) async {
    JsonRoom json = JsonRoom.fromJson(doc.json);
    json = json.clone(
      playerIds: [...json.playerIds, Constants.PLAYER_2],
      players: {...json.players, Constants.PLAYER_2: playerName},
    );
    final String matchId = await _createMatch(json);
    json.clone(matchId: matchId);

    await RoomRepository.update(json);

    return json.object;
  }

  static Future<String> _createMatch(JsonRoom room) async {
    final String content = await rootBundle.loadString(
      'assets/templates/w5h7.json',
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

    return MatchRepository.create(jsonMatch.clone(players: namedPlayers));
  }

  static Future<Room> create(JsonRoom json) async {
    final String roomId = Id.roomId(4);
    final DocumentReference ref = _ref(roomId);
    final JsonRoom finalJson = json.clone(id: ref.id);
    await ref.set(finalJson.toJson());

    return finalJson.object;
  }

  static StreamSubscription listen({
    required String roomId,
    required Function(Room) onUpdated,
  }) => _ref(roomId).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonRoom json = JsonRoom.fromJson(snapshot.json);
      onUpdated(json.object);
    }
  }, onError: ErrorHandler.process);

  static Future<Room> load(String roomId) async {
    final DocumentSnapshot snapshot = await _ref(roomId).get();

    if (snapshot.exists) {
      final JsonRoom json = JsonRoom.fromJson(snapshot.json);
      return json.object;
    } else {
      throw Exception('Room with ID $roomId not found');
    }
  }

  static Future<Room> update(JsonRoom json) async {
    await _ref(json.id).update(json.toJson());

    return json.object;
  }
}
