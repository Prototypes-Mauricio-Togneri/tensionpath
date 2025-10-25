import 'dart:io';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/api/json_player.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/types/building_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/logger.dart';
import 'package:tensionpath/utils/match_loader.dart';

class Connection {
  final String matchId;
  final String mapId;
  final DateTime createdAt;
  final int numberOfPlayers;
  final String matchType;
  final Map<String, Participant> participants;
  Match? _match;

  Connection._({
    required this.matchId,
    required this.mapId,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.participants,
  });

  factory Connection.fromJson(JsonCreateMatch json) {
    final Map<String, Participant> participants = {};
    int index = 1;

    for (final MapEntry<String, JsonPlayer> player in json.players.entries) {
      final String playerId = player.key;
      final JsonPlayer playerData = player.value;

      participants[playerId] = Participant(
        playerId: playerId,
        playerIndex: index.toString(),
        playerName: playerData.name,
        deck: playerData.deck,
      );

      index++;
    }

    return Connection._(
      matchId: json.matchId,
      mapId: json.mapId,
      createdAt: json.createdAt,
      numberOfPlayers: json.numberOfPlayers,
      matchType: json.matchType,
      participants: participants,
    );
  }

  bool get isEmpty => (_match != null) && (connectedParticipants == 0);

  int get connectedParticipants =>
      participants.values.where((p) => p.isConnected).length;

  void join({
    required String playerId,
    required WebSocket socket,
  }) {
    if ((_match == null) && participants.containsKey(playerId)) {
      final Participant participant = participants[playerId]!;
      participant.socket = socket;

      Logger.log(socket, 'Player $playerId joined match $matchId');

      if (connectedParticipants == numberOfPlayers) {
        Logger.log(socket, 'Match $matchId started');
        _onMatchStart();
      }
    } else {
      throw JsonMessage.error('Player $playerId cannot join match $matchId');
    }
  }

  void leave(WebSocket socket) {
    final Participant participant = participantBySocket(socket);
    participant.socket = null;
    Logger.log(socket, 'Player ${participant.playerId} left match $matchId');
  }

  Future _onMatchStart() async {
    final JsonMatchStart jsonMatch = await MatchLoader.load(
      path: 'assets/$mapId.json',
      participants: participants,
    );

    _match = Match.fromJson(
      connection: this,
      jsonMatch: jsonMatch,
    );

    _match?.start();
  }

  void unlockBuilding({
    required WebSocket socket,
    required BuildingType type,
  }) {
    final Participant participant = participantBySocket(socket);
    _match?.unlockBuilding(
      playerIndex: participant.playerIndex,
      type: type,
    );
  }

  void deployUnit({
    required WebSocket socket,
    required JsonLocation location,
    required UnitType type,
  }) {
    final Participant participant = participantBySocket(socket);
    _match?.deployUnit(
      playerIndex: participant.playerIndex,
      location: Location.fromJson(location),
      type: type,
    );
  }

  void unitAction({
    required WebSocket socket,
    required String unitId,
    required JsonLocation? targetLocation,
    required String? targetUnitId,
  }) {
    final Participant participant = participantBySocket(socket);
    _match?.unitAction(
      playerIndex: participant.playerIndex,
      unitId: unitId,
      targetLocation: targetLocation != null
          ? Location.fromJson(targetLocation)
          : null,
      targetUnitId: targetUnitId,
    );
  }

  void surrenderMatch(WebSocket socket) {
    final Participant participant = participantBySocket(socket);
    _match?.surrenderMatch(participant.playerIndex);
  }

  Participant participantBySocket(WebSocket socket) {
    for (final Participant participant in participants.values) {
      if (participant.hasSocket(socket)) {
        return participant;
      }
    }

    throw JsonMessage.error('Participant with socket ${socket.id} not found');
  }

  Participant participantByIndex(String index) {
    for (final Participant participant in participants.values) {
      if (participant.playerIndex == index) {
        return participant;
      }
    }

    throw JsonMessage.error('Participant $index not found');
  }

  void direct({
    required String playerIndex,
    required JsonMessage json,
  }) {
    final Participant participant = participantByIndex(playerIndex);

    if (participant.isConnected) {
      participant.socket.send(json);
    }
  }

  void broadcast(JsonMessage json) {
    for (final Participant participant in participants.values) {
      if (participant.isConnected) {
        participant.socket.send(json);
      }
    }
  }

  void update(double dt) => _match?.update(dt);
}

class Participant {
  final String playerId;
  final String playerIndex;
  final String playerName;
  final List<UnitType> deck;
  WebSocket? _socket;

  Participant({
    required this.playerId,
    required this.playerIndex,
    required this.playerName,
    required this.deck,
  });

  bool get isConnected => _socket != null;

  WebSocket get socket => _socket!;

  set socket(WebSocket? socket) {
    _socket = socket;
  }

  bool hasSocket(WebSocket socket) => _socket == socket;
}
