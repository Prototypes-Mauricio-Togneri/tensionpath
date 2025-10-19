import 'dart:convert';
import 'dart:io';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/size.dart';
import 'package:tensionpath/domain/json/models/common/json_position.dart';
import 'package:tensionpath/domain/json/models/common/json_size.dart';
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
import 'package:tensionpath/domain/json/models/template/json_match_template.dart';
import 'package:tensionpath/domain/json/models/template/json_node_template.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/server/connection.dart';
import 'package:tensionpath/utils/constants.dart';

class MatchLoader {
  static Future<JsonMatchStart> load({
    required String path,
    required Map<String, Participant> participants,
  }) async {
    final JsonMatchTemplate jsonMatchTemplate = _getJsonMatchTemplate(path);
    final Config config = Config.fromJson(jsonMatchTemplate.config);

    return JsonMatchStart(
      createdAt: DateTime.now().toUtc().toIso8601String(),
      config: jsonMatchTemplate.config,
      players: _getJsonPlayersStart(
        config: config,
        participants: participants,
      ),
      battlefield: _getJsonBattlefieldStart(
        config: config,
        jsonMatchTemplate: jsonMatchTemplate,
      ),
    );
  }

  static JsonMatchTemplate _getJsonMatchTemplate(String path) {
    final File file = File(path);
    final String contents = file.readAsStringSync();
    final dynamic json = jsonDecode(contents) as Map<String, dynamic>;

    return JsonMatchTemplate.fromJson(json);
  }

  static List<JsonPlayerStart> _getJsonPlayersStart({
    required Config config,
    required Map<String, Participant> participants,
  }) {
    final List<JsonPlayerStart> jsonPlayersStart = [];

    for (final Participant participant in participants.values) {
      final List<UnitType> deck = [
        UnitType.harvester,
        ...participant.deck,
      ];
      deck.sort((a, b) => a.index.compareTo(b.index));

      jsonPlayersStart.add(
        JsonPlayerStart(
          id: participant.playerId,
          name: participant.playerName,
          isSelf: false,
          index: participant.playerIndex,
          baseHealth: config.baseHealth,
          baseMaxHealth: config.baseHealth,
          resources: config.resourcesStart,
          resourcesPassiveRate: config.resourcesPassiveRate,
          resourcesActiveRate: config.resourcesActiveRate,
          deck: deck,
        ),
      );
    }

    return jsonPlayersStart;
  }

  static JsonBattlefieldStart _getJsonBattlefieldStart({
    required Config config,
    required JsonMatchTemplate jsonMatchTemplate,
  }) {
    final List<JsonNodeStart> jsonNodeStart = _getJsonNodesStart(
      jsonMatchTemplate.battlefield,
    );

    return JsonBattlefieldStart(
      mapSize: jsonMatchTemplate.battlefield.mapSize,
      nodeSize: JsonSize(
        width: Constants.NODE_SIZE.width,
        height: Constants.NODE_SIZE.height,
      ),
      nodes: jsonNodeStart,
      missile: _getJsonMissileStart(
        config: config,
        nodes: jsonNodeStart,
      ),
      resources: _getJsonResourcesStart(
        config: config,
        nodes: jsonNodeStart,
      ),
      launchers: _getJsonLaunchersStart(jsonNodeStart),
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
          playerIndex: jsonNode.playerIndex,
          platformId: jsonNode.platformId,
        ),
      );
    }

    return jsonNodesStart;
  }

  static JsonMissileStart _getJsonMissileStart({
    required Config config,
    required List<JsonNodeStart> nodes,
  }) {
    final JsonNodeStart node = _getMissileNode(nodes);

    return JsonMissileStart(
      location: node.location,
      position: node.position,
      chargeMax: config.missileMaxCharge,
      chargeBuffer: config.missileChargeBuffer,
      chargeAlarm: config.missileChargeAlarm,
      chargeRate: config.missileChargeRate,
      damage: config.missileDamage,
      platforms: _getJsonPlatformStart(nodes),
    );
  }

  static JsonNodeStart _getMissileNode(List<JsonNodeStart> nodes) {
    for (final JsonNodeStart node in nodes) {
      if (node.type == NodeType.missile) {
        return node;
      }
    }

    throw Exception('No missile node found');
  }

  static List<JsonPlatformStart> _getJsonPlatformStart(
    List<JsonNodeStart> nodes,
  ) {
    final Map<String, List<JsonPadStart>> result = {};

    for (final JsonNodeStart node in nodes) {
      if (node.type == NodeType.pad) {
        final JsonPadStart pad = JsonPadStart(
          location: node.location,
          position: node.position,
        );

        if (result.containsKey(node.platformId)) {
          result[node.platformId!]!.add(pad);
        } else {
          result[node.platformId!] = [pad];
        }
      }
    }

    return result.entries
        .map(
          (entry) => JsonPlatformStart(
            id: entry.key,
            pads: entry.value,
          ),
        )
        .toList();
  }

  static List<JsonResourceStart> _getJsonResourcesStart({
    required Config config,
    required List<JsonNodeStart> nodes,
  }) {
    final List<JsonResourceStart> result = [];
    final num patchAmount = config.resourcesPerPatch;

    for (final JsonNodeStart node in nodes) {
      if (node.type == NodeType.resources) {
        result.add(
          JsonResourceStart(
            id: node.location.id,
            location: node.location,
            position: node.position,
            amountCurrent: patchAmount,
            amountMax: patchAmount,
          ),
        );
      }
    }

    return result;
  }

  static List<JsonLauncherStart> _getJsonLaunchersStart(
    List<JsonNodeStart> nodes,
  ) {
    final List<JsonLauncherStart> result = [];

    for (final JsonNodeStart node in nodes) {
      if (node.type == NodeType.launcher) {
        result.add(
          JsonLauncherStart(
            playerIndex: node.playerIndex!,
            location: node.location,
            position: node.position,
          ),
        );
      }
    }

    return result;
  }

  static JsonPosition _getNodePosition({
    required Size nodeSize,
    required Location location,
  }) => JsonPosition(
    x: nodeSize.width * ((location.y / 2) + location.x),
    y: nodeSize.height * 3 / 4 * location.y,
  );
}
