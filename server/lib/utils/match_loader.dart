import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/json/models/common/json_location.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/start/json_battlefield_start.dart';
import 'package:tensionpath/domain/json/models/start/json_launcher_start.dart';
import 'package:tensionpath/domain/json/models/start/json_match_start.dart';
import 'package:tensionpath/domain/json/models/start/json_missile_start.dart';
import 'package:tensionpath/domain/json/models/start/json_node_start.dart';
import 'package:tensionpath/domain/json/models/start/json_pad_start.dart';
import 'package:tensionpath/domain/json/models/start/json_platform_start.dart';
import 'package:tensionpath/domain/json/models/start/json_player_start.dart';
import 'package:tensionpath/domain/json/models/start/json_resource_start.dart';
import 'package:tensionpath/domain/json/models/template/json_battlefield_template.dart';
import 'package:tensionpath/domain/json/models/template/json_launchers_template.dart';
import 'package:tensionpath/domain/json/models/template/json_match_template.dart';
import 'package:tensionpath/domain/json/models/template/json_missile_template.dart';
import 'package:tensionpath/domain/json/models/template/json_node_template.dart';
import 'package:tensionpath/domain/json/models/template/json_platform_template.dart';
import 'package:tensionpath/domain/json/models/template/json_player_template.dart';
import 'package:tensionpath/domain/json/models/template/json_resource_template.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/constants.dart';

class MatchLoader {
  static Future<JsonMatchStart> load({
    required String path,
    required Map<String, Participant> participants,
  }) async {
    final JsonMatchTemplate jsonMatchTemplate = _getJsonMatchTemplate(path);

    return JsonMatchStart(
      createdAt: DateTime.now().toUtc().toIso8601String(),
      players: _getJsonPlayersStart(
        participants: participants,
        playersTemplate: jsonMatchTemplate.players,
      ),
      battlefield: _getJsonBattlefieldStart(jsonMatchTemplate),
    );
  }

  static JsonMatchTemplate _getJsonMatchTemplate(String path) {
    final File file = File(path);
    final String contents = file.readAsStringSync();
    final dynamic json = jsonDecode(contents) as Map<String, dynamic>;

    return JsonMatchTemplate.fromJson(json);
  }

  static List<JsonPlayerStart> _getJsonPlayersStart({
    required Map<String, Participant> participants,
    required List<JsonPlayerTemplate> playersTemplate,
  }) {
    final List<JsonPlayerStart> jsonPlayersStart = [];

    for (final Participant participant in participants.values) {
      final JsonPlayerTemplate jsonPlayerTemplate = playersTemplate.firstWhere(
        (p) => p.index == participant.playerIndex,
      );

      jsonPlayersStart.add(
        JsonPlayerStart(
          id: participant.playerId,
          name: participant.playerName,
          isSelf: false,
          index: jsonPlayerTemplate.index,
          baseHealth: jsonPlayerTemplate.baseHealth,
          baseMaxHealth: jsonPlayerTemplate.baseMaxHealth,
          resources: jsonPlayerTemplate.resources,
          resourcesRateBase: jsonPlayerTemplate.resourcesRateBase,
        ),
      );
    }

    return jsonPlayersStart;
  }

  static JsonBattlefieldStart _getJsonBattlefieldStart(
    JsonMatchTemplate jsonMatchTemplate,
  ) {
    final List<JsonNodeStart> jsonNodeStart = _getJsonNodesStart(
      jsonMatchTemplate.battlefield,
    );

    return JsonBattlefieldStart(
      mapSize: jsonMatchTemplate.battlefield.mapSize,
      nodeSize: jsonMatchTemplate.battlefield.nodeSize,
      nodes: jsonNodeStart,
      missile: _getJsonMissileStart(
        missileTemplate: jsonMatchTemplate.battlefield.missile,
        nodes: jsonNodeStart,
      ),
      resources: _getJsonResourcesStart(
        resources: jsonMatchTemplate.battlefield.resources,
        nodes: jsonNodeStart,
      ),
      launchers: _getJsonLaunchersStart(
        launchers: jsonMatchTemplate.battlefield.launchers,
        nodes: jsonNodeStart,
      ),
    );
  }

  static List<JsonNodeStart> _getJsonNodesStart(
    JsonBattlefieldTemplate battlefield,
  ) {
    final List<JsonNodeStart> jsonNodesStart = [];

    for (final JsonNodeTemplate jsonNode in battlefield.nodes) {
      jsonNodesStart.add(
        JsonNodeStart(
          type: jsonNode.type,
          location: jsonNode.location,
          position: _getNodePosition(
            nodeSize: Constants.NODE_SIZE,
            location: Location.fromJson(jsonNode.location),
          ),
        ),
      );
    }

    return jsonNodesStart;
  }

  static JsonMissileStart _getJsonMissileStart({
    required JsonMissileTemplate missileTemplate,
    required List<JsonNodeStart> nodes,
  }) {
    final JsonNodeStart node = _getNodeByLocation(
      location: missileTemplate.location,
      nodes: nodes,
    );

    return JsonMissileStart(
      location: missileTemplate.location,
      position: node.position,
      chargeMax: missileTemplate.chargeMax,
      chargeBuffer: missileTemplate.chargeBuffer,
      platforms: _getJsonPlatformStart(
        platforms: missileTemplate.platforms,
        nodes: nodes,
      ),
    );
  }

  static List<JsonPlatformStart> _getJsonPlatformStart({
    required List<JsonPlatformTemplate> platforms,
    required List<JsonNodeStart> nodes,
  }) {
    final List<JsonPlatformStart> result = [];

    for (final JsonPlatformTemplate platform in platforms) {
      final List<JsonPadStart> pads = [];

      for (final JsonLocation padPosition in platform.pads) {
        final JsonNodeStart node = _getNodeByLocation(
          location: padPosition,
          nodes: nodes,
        );

        pads.add(
          JsonPadStart(
            location: node.location,
            position: node.position,
          ),
        );
      }

      result.add(
        JsonPlatformStart(
          id: platform.id,
          pads: pads,
        ),
      );
    }

    return result;
  }

  static List<JsonResourceStart> _getJsonResourcesStart({
    required List<JsonResourceTemplate> resources,
    required List<JsonNodeStart> nodes,
  }) {
    final List<JsonResourceStart> result = [];

    for (final JsonResourceTemplate resource in resources) {
      final JsonNodeStart node = _getNodeByLocation(
        location: resource.location,
        nodes: nodes,
      );

      result.add(
        JsonResourceStart(
          id: resource.id,
          location: node.location,
          position: node.position,
          amountCurrent: resource.amountCurrent,
          amountMax: resource.amountMax,
        ),
      );
    }

    return result;
  }

  static List<JsonLauncherStart> _getJsonLaunchersStart({
    required List<JsonLaunchersTemplate> launchers,
    required List<JsonNodeStart> nodes,
  }) {
    final List<JsonLauncherStart> result = [];

    for (final JsonLaunchersTemplate launcher in launchers) {
      for (final JsonLocation locaction in launcher.locations) {
        final JsonNodeStart node = _getNodeByLocation(
          location: locaction,
          nodes: nodes,
        );

        result.add(
          JsonLauncherStart(
            playerIndex: launcher.playerIndex,
            location: node.location,
            position: node.position,
          ),
        );
      }
    }

    return result;
  }

  static JsonNodeStart _getNodeByLocation({
    required JsonLocation location,
    required List<JsonNodeStart> nodes,
  }) => nodes.firstWhere((node) => node.location.id == location.id);

  static JsonPosition _getNodePosition({
    required Size nodeSize,
    required Location location,
  }) => JsonPosition(
    x: nodeSize.width * ((location.y / 2) + location.x),
    y: nodeSize.height * 3 / 4 * location.y,
  );
}
