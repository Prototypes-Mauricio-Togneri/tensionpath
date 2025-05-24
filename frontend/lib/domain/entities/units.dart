import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/units_component.dart';
import 'package:tensionpath/domain/entities/localizable.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class Units implements Localizable {
  Player player;
  int amount;
  final Location location;
  Location? moveTo;

  Units({
    required this.player,
    required this.amount,
    required this.location,
    required this.moveTo,
  });

  void replaceWith(Units newUnits) {
    player = newUnits.player;
    amount = newUnits.amount;
  }

  void addUnit() {
    amount++;
  }

  void moveUnit(Location newLocation) {
    moveTo = newLocation;
  }

  bool belongsTo(Player player) => this.player.id == player.id;

  @override
  Location get getLocation => location;

  int distance(Localizable localizable) => location.distance(localizable);

  UnitsComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => UnitsComponent(units: this, node: node, position: position, size: size);
}
