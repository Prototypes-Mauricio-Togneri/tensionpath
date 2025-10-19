import 'package:tensionpath/domain/entities/player.dart';
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
}
