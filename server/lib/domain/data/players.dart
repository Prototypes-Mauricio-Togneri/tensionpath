import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/utils/iterable_map.dart';

class Players {
  final IterableMap<String, Player> _players;

  const Players(this._players);

  Player get(String id) => _players.get(id);

  List<Player> get list => _players.list;

  Player other(Player player) {
    for (final Player currentPlayer in _players) {
      if (currentPlayer.id != player.id) {
        return currentPlayer;
      }
    }

    throw Exception('No other player found for id ${player.id}');
  }
}
