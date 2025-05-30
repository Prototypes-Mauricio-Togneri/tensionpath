import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_match_player.dart';
import 'package:tensionpath/domain/json/json_room.dart';
import 'package:tensionpath/domain/json/json_room_player.dart';
import 'package:tensionpath/domain/types/room_status.dart';
import 'package:tensionpath/domain/types/room_visibility.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/utils/error_handler.dart';

class RoomRepository {
  static DocumentReference _ref([String? roomId]) =>
      FirebaseFirestore.instance.collection('rooms').doc(roomId);

  static Future<String> startMatchmaking({
    required String userId,
    required String playerName,
  }) async {
    final JsonRoom? jsonRoom = await _getAvailableRoom(
      userId: userId,
      playerName: playerName,
    );

    if (jsonRoom == null) {
      return _createRoom(userId: userId, playerName: playerName);
    } else {
      if (jsonRoom.players.containsKey(userId)) {
        return jsonRoom.id;
      } else {
        return _joinRoom(
          userId: userId,
          playerName: playerName,
          json: jsonRoom,
        );
      }
    }
  }

  static Future<JsonRoom?> _getAvailableRoom({
    required String userId,
    required String playerName,
  }) async {
    final CollectionReference ref = FirebaseFirestore.instance.collection(
      'rooms',
    );

    final Query queryJoinedRoom = ref
        .where('status', isEqualTo: RoomStatus.open.name)
        .where('version', isEqualTo: 1)
        .where('matchType', isEqualTo: '1v1')
        .where('userIds', arrayContains: userId)
        .where('numberOfPlayers', isEqualTo: 2)
        .where('visibility', isEqualTo: RoomVisibility.public.name)
        .limit(1);

    final QuerySnapshot snapshotJoinedRoom = await queryJoinedRoom.get();

    if (snapshotJoinedRoom.docs.isNotEmpty) {
      return JsonRoom.fromJson(snapshotJoinedRoom.docs.first.json);
    } else {
      final Query queryOpenRoom = ref
          .where('status', isEqualTo: RoomStatus.open.name)
          .where('version', isEqualTo: 1)
          .where('matchType', isEqualTo: '1v1')
          .where('numberOfPlayers', isEqualTo: 2)
          .where('visibility', isEqualTo: RoomVisibility.public.name)
          .limit(1);

      final QuerySnapshot snapshotOpenRoom = await queryOpenRoom.get();

      if (snapshotOpenRoom.docs.isNotEmpty) {
        return JsonRoom.fromJson(snapshotOpenRoom.docs.first.json);
      } else {
        return null;
      }
    }
  }

  static Future<String> _createRoom({
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
      players: {
        userId: JsonRoomPlayer(playerId: Constants.PLAYER_1, name: playerName),
      },
      matchId: null,
    );
    await ref.set(jsonRoom.toJson());

    return jsonRoom.id;
  }

  static Future<String> _joinRoom({
    required String userId,
    required String playerName,
    required JsonRoom json,
  }) async {
    JsonRoom jsonRoom = json.clone(
      status: RoomStatus.closed,
      players: {
        ...json.players,
        userId: JsonRoomPlayer(playerId: Constants.PLAYER_2, name: playerName),
      },
    );
    final String matchId = await _createMatch(jsonRoom);
    jsonRoom = jsonRoom.clone(matchId: matchId);

    await RoomRepository.update(jsonRoom);

    return jsonRoom.id;
  }

  static Future<String> _createMatch(JsonRoom room) async {
    JsonMatch jsonMatch = await JsonMatch.fromTemplate(
      'assets/templates/w5h7.json',
    );
    jsonMatch = jsonMatch.clone(
      createdAt: DateTime.now(),
      turn: jsonMatch.turn.clone(startedAt: DateTime.now()),
      players: _mergePlayers(
        roomPlayers: room.players,
        players: jsonMatch.players,
      ),
    );

    return MatchRepository.create(jsonMatch);
  }

  static List<JsonMatchPlayer> _mergePlayers({
    required Map<String, JsonRoomPlayer> roomPlayers,
    required List<JsonMatchPlayer> players,
  }) {
    final List<JsonMatchPlayer> result = [];

    for (final JsonMatchPlayer player in players) {
      final JsonRoomPlayer roomPlayer = roomPlayers.values.firstWhere(
        (roomPlayer) => roomPlayer.playerId == player.id,
      );
      result.add(player.clone(name: roomPlayer.name));
    }

    return result;
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
