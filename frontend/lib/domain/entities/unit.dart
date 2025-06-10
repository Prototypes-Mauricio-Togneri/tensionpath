import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class Unit implements Localizable {
  Player player;
  int level;
  final Location location;

  Unit({required this.player, required this.level, required this.location});

  void replaceWith(Unit newUnit) {
    player = newUnit.player;
    level = newUnit.level;
  }

  bool belongsTo(Player player) => this.player.id == player.id;

  @override
  Location get getLocation => location;

  int distance(Localizable localizable) =>
      location.distance(localizable.getLocation);
}
