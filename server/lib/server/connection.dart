import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/match.dart';
import 'package:tensionpath/domain/engine/size.dart';
import 'package:tensionpath/domain/json/api/json_create_match.dart';
import 'package:tensionpath/domain/json/messages/json_message.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/web_socket_extension.dart';
import 'package:tensionpath/utils/constants.dart';
import 'package:tensionpath/utils/logger.dart';

class Connection {
  final String matchId;
  final DateTime createdAt;
  final int numberOfPlayers;
  final String matchType;
  final Map<String, Participant> participants;
  Match? _match;

  Connection._({
    required this.matchId,
    required this.createdAt,
    required this.numberOfPlayers,
    required this.matchType,
    required this.participants,
  });

  factory Connection.fromJson(JsonCreateMatch json) {
    final Map<String, Participant> participants = {};
    int index = 1;

    for (final MapEntry<String, String> player in json.players.entries) {
      final String playerId = player.key;
      final String playerName = player.value;

      participants[playerId] = Participant(
        playerId: playerId,
        playerIndex: index.toString(),
        playerName: playerName,
      );

      index++;
    }

    return Connection._(
      matchId: json.matchId,
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
        Logger.info('Match $matchId started');
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
    final JsonMatch jsonMatch = await _getMatchTemplate(
      path: 'assets/w9h7.json',
      participants: participants,
    );

    _match = Match.fromJson(
      connection: this,
      jsonMatch: jsonMatch,
    );

    for (final Participant participant in participants.values) {
      for (final JsonPlayer jsonPlayer in jsonMatch.players) {
        jsonPlayer.isSelf = (jsonPlayer.id == participant.playerId);
      }

      direct(
        playerIndex: participant.playerIndex,
        json: JsonMessage.start(jsonMatch),
      );
    }
  }

  Future<JsonMatch> _getMatchTemplate({
    required String path,
    required Map<String, Participant> participants,
  }) async {
    final File file = File(path);
    final String contents = await file.readAsString();
    final dynamic json = jsonDecode(contents) as Map<String, dynamic>;

    final JsonMatch jsonMatch = JsonMatch.fromJson(json);
    jsonMatch.createdAt = DateTime.now().toUtc().toIso8601String();

    for (final JsonNode jsonNode in jsonMatch.battlefield.nodes) {
      jsonNode.type = _getNodeType(
        positionId: jsonNode.location.id,
        missile: jsonMatch.battlefield.missile,
        resources: jsonMatch.battlefield.resources,
        launchers: jsonMatch.battlefield.launchers,
      );
      jsonNode.position = _position(
        nodeSize: Constants.NODE_SIZE,
        location: Location.fromJson(jsonNode.location),
      );
    }

    for (final Participant participant in participants.values) {
      final JsonPlayer jsonPlayer = jsonMatch.players.firstWhere(
        (p) => p.index == participant.playerIndex,
      );
      jsonPlayer.id = participant.playerId;
      jsonPlayer.name = participant.playerName;
    }

    return jsonMatch;
  }

  NodeType _getNodeType({
    required String positionId,
    required JsonMissile missile,
    required List<JsonResource> resources,
    required List<JsonLaunchers> launchers,
  }) {
    if (missile.location.id == positionId) {
      return NodeType.missile;
    }

    final List<JsonLocation> padsPositions = missile.platforms
        .map((p) => p.pads)
        .expand((p) => p)
        .toList();

    if (padsPositions.any((pad) => pad.id == positionId)) {
      return NodeType.pad;
    }

    if (resources.any((resource) => resource.location.id == positionId)) {
      return NodeType.resources;
    }

    final List<JsonLocation> launchersPositions = launchers
        .map((launchers) => launchers.locations)
        .expand((locations) => locations)
        .toList();

    if (launchersPositions.any((launcher) => launcher.id == positionId)) {
      return NodeType.launcher;
    }

    return NodeType.empty;
  }

  static JsonPosition _position({
    required Size nodeSize,
    required Location location,
  }) => JsonPosition(
    x: nodeSize.width * ((location.y / 2) + location.x),
    y: nodeSize.height * 3 / 4 * location.y,
  );

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
  WebSocket? _socket;

  Participant({
    required this.playerId,
    required this.playerIndex,
    required this.playerName,
  });

  bool get isConnected => _socket != null;

  WebSocket get socket => _socket!;

  set socket(WebSocket? socket) {
    _socket = socket;
  }

  bool hasSocket(WebSocket socket) => _socket == socket;
}
