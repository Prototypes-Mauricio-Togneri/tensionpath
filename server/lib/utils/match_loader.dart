import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/engine/location.dart';
import 'package:tensionpath/domain/engine/size.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/start/json_launchers.dart';
import 'package:tensionpath/domain/json/models/start/json_match.dart';
import 'package:tensionpath/domain/json/models/start/json_missile.dart';
import 'package:tensionpath/domain/json/models/start/json_node.dart';
import 'package:tensionpath/domain/json/models/start/json_player.dart';
import 'package:tensionpath/domain/json/models/start/json_resource.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/constants.dart';

class MatchLoader {
  static Future<JsonMatch> load({
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

  static NodeType _getNodeType({
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
}
