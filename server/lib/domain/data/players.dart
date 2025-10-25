import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/json/messages/server_client/json_event.dart';
import 'package:tensionpath/domain/json/models/events/json_event_player.dart';
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

  List<JsonEvent> events(Units units) {
    final List<JsonEvent> result = [];

    for (final Player player in _players) {
      result.add(
        JsonEvent.player(
          JsonEventPlayer(
            index: player.index,
            resources: player.resources,
            resourcesRate:
                player.resourcesPassiveRate +
                (units.currentHarvestersWorking(player.index) *
                    player.resourcesActiveRate),
            currentHarvesterCount: units.currentHarvesterCount(player.index),
            maxHarvestersCount: units.maxHarvesterCount(player.index),
          ),
        ),
      );
    }

    return result;
  }
}
