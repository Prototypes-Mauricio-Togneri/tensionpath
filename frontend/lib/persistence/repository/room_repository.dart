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

  static Future<MatchmakingInfo> getAvailableRoom({
    required String userId,
    required String playerName,
  }) async {
    final JsonRoom? joinedRoom = await _getJoinedRoom(
      userId: userId,
      playerName: playerName,
    );

    if (joinedRoom != null) {
      return _joinRoom(playerName: playerName, json: joinedRoom);
    } else {
      final JsonRoom? openRoom = await _getOpenRoom();

      if (openRoom != null) {
        return _joinRoom(playerName: playerName, json: openRoom);
      } else {
        return _createRoom(userId: userId, playerName: playerName);
      }
    }
  }

  static Future<JsonRoom?> _getJoinedRoom({
    required String userId,
    required String playerName,
  }) async {
    final CollectionReference ref = FirebaseFirestore.instance.collection(
      'rooms',
    );

    final Query query = ref
        .where('status', isEqualTo: RoomStatus.open.name)
        .where('version', isEqualTo: 1)
        .where('matchType', isEqualTo: '1v1')
        .where('userIds', arrayContains: userId)
        .where('numberOfPlayers', isEqualTo: 2)
        .where('visibility', isEqualTo: RoomVisibility.public.name)
        .limit(1);

    final QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      return JsonRoom.fromJson(snapshot.docs.first.json);
    } else {
      return null;
    }
  }

  static Future<JsonRoom?> _getOpenRoom() async {
    final CollectionReference ref = FirebaseFirestore.instance.collection(
      'rooms',
    );

    final Query query = ref
        .where('status', isEqualTo: RoomStatus.open.name)
        .where('version', isEqualTo: 1)
        .where('matchType', isEqualTo: '1v1')
        .where('numberOfPlayers', isEqualTo: 2)
        .where('visibility', isEqualTo: RoomVisibility.public.name)
        .limit(1);

    final QuerySnapshot snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      return JsonRoom.fromJson(snapshot.docs.first.json);
    } else {
      return null;
    }
  }

  static Future<MatchmakingInfo> _createRoom({
    required String userId,
    required String playerName,
  }) async {
    final DocumentReference ref = _ref();
    final JsonRoom jsonRoom = JsonRoom(
      id: ref.id,
      version: 1,
      createdAt: DateTime.now(),
      numberOfPlayers: 2,
      visibility: RoomVisibility.public,
      status: RoomStatus.open,
      matchType: '1v1',
      userIds: [userId],
      players: {Constants.PLAYER_1: playerName},
      matchId: null,
    );
    await ref.set(jsonRoom.toJson());

    return MatchmakingInfo(roomId: jsonRoom.id, playerId: Constants.PLAYER_1);
  }

  static Future<MatchmakingInfo> _joinRoom({
    required String playerName,
    required JsonRoom json,
  }) async {
    JsonRoom jsonRoom = json.clone(
      status: RoomStatus.closed,
      players: {...json.players, Constants.PLAYER_2: playerName},
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
