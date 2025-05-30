import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/matchmaking_info.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/error_handler.dart';

class RoomRepository {
  static DocumentReference _ref([String? roomId]) =>
      FirebaseFirestore.instance.collection('rooms').doc(roomId);

  static Future<MatchmakingInfo> search(String playerName) async {
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

  static Future<MatchmakingInfo> _createRoom(String playerName) async {
    final DocumentReference ref = _ref();
    final JsonRoom jsonRoom = JsonRoom(
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
    await ref.set(jsonRoom.toJson());

    return MatchmakingInfo(roomId: jsonRoom.id, playerId: Constants.PLAYER_1);
  }

  static Future<MatchmakingInfo> _joinRoom({
    required String playerName,
    required DocumentSnapshot doc,
  }) async {
    JsonRoom jsonRoom = JsonRoom.fromJson(doc.json);
    jsonRoom = jsonRoom.clone(
      playerIds: [...jsonRoom.playerIds, Constants.PLAYER_2],
      players: {...jsonRoom.players, Constants.PLAYER_2: playerName},
    );
    final String matchId = await _createMatch(jsonRoom);
    jsonRoom = jsonRoom.clone(matchId: matchId);

    await RoomRepository.update(jsonRoom);

    return MatchmakingInfo(roomId: jsonRoom.id, playerId: Constants.PLAYER_2);
  }

  static Future<String> _createMatch(JsonRoom room) async {
    JsonMatch jsonMatch = await JsonMatch.fromTemplate(
      'assets/templates/w5h7.json',
    );
    final List<JsonPlayer> namedPlayers = [];

    for (final JsonPlayer jsonPlayer in jsonMatch.players) {
      namedPlayers.add(jsonPlayer.clone(name: room.players[jsonPlayer.id]));
    }

    jsonMatch = jsonMatch.clone(
      createdAt: DateTime.now(),
      turn: jsonMatch.turn.clone(startedAt: DateTime.now()),
      players: namedPlayers,
    );

    return MatchRepository.create(jsonMatch);
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

  static Future<Room> update(JsonRoom json) async {
    await _ref(json.id).update(json.toJson());

    return json.object;
  }
}
