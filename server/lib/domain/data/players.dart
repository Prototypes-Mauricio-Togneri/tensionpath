import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/messages/server_client/events/json_event_player.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Players {
  final IterableMap<String, Player> _players;

  const Players(this._players);

  Player get(String id) => _players.get(id);

  List<Player> get list => _players.list;

  Player other(String playerIndex) {
    for (final Player player in _players) {
      if (player.index != playerIndex) {
        return player;
      }
    }

    throw Exception('No other player found with index $playerIndex');
  }

  Map<String, JsonEventPlayer> events(Units units) {
    final Map<String, JsonEventPlayer> result = {};

    for (final Player player in _players) {
      result[player.index] = JsonEventPlayer(
        health: player.baseHealth,
        resources: player.resources,
        resourcesRate:
            units.currentHarvestersWorking(player.index) *
            player.resourcesActiveRate,
        currentHarvesterCount: units.currentHarvesterCount(player.index),
      );
    }

    return result;
  }

  List<JsonEvent> newEvents({
    required Map<String, JsonEventPlayer> previousEvents,
    required Map<String, JsonEventPlayer> newEvents,
  }) {
    final List<JsonEventPlayer> result = [];

    for (final MapEntry<String, JsonEventPlayer> entry
        in previousEvents.entries) {
      final JsonEventPlayer previousEvent = entry.value;
      final JsonEventPlayer newEvent = newEvents[entry.key]!;

      if (newEvent.hasChanged(previousEvent)) {
        result.add(newEvent);
      }
    }

    return result.map(JsonEvent.player).toList();
  }
}
