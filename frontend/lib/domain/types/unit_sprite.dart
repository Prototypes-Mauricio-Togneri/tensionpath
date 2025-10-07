import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

String cardUnitSprite(UnitType type) =>
    'assets/images/units/cards/${type.clazz.name}/${type.name}.png';

String matchUnitSprite({
  required UnitType type,
  required Player player,
}) => 'units/player_${player.index}/${type.clazz.name}/${type.name}.png';

double controlsUnitScale(UnitType type) {
  switch (type) {
    case UnitType.harvester:
      return 0.75;

    case UnitType.riflemen:
      return 0.6;
    case UnitType.shocks:
      return 0.65;
    case UnitType.missiles:
      return 0.65;
    case UnitType.grenadier:
      return 0.55;
    case UnitType.sniper:
      return 0.6;

    case UnitType.rhino:
      return 0.6;
    case UnitType.pitbull:
      return 0.65;
    case UnitType.shatterer:
      return 0.5;
    case UnitType.predator:
      return 1;
    case UnitType.mlrs:
      return 0.75;

    case UnitType.talon:
      return 0.8;
    case UnitType.razorback:
      return 0.6;
    case UnitType.orca:
      return 0.8;
    case UnitType.mohawk:
      return 0.85;
    case UnitType.hammerhead:
      return 0.7;
  }
}

Vector2 battlefieldUnitScale(UnitType type) {
  switch (type) {
    case UnitType.harvester:
      return Vector2(0.6, 0.6);

    case UnitType.riflemen:
      return Vector2(0.5, 0.5);
    case UnitType.shocks:
      return Vector2(0.45, 0.45);
    case UnitType.missiles:
      return Vector2(0.45, 0.45);
    case UnitType.grenadier:
      return Vector2(0.35, 0.35);
    case UnitType.sniper:
      return Vector2(0.5, 0.5);

    case UnitType.rhino:
      return Vector2(0.4, 0.4);
    case UnitType.pitbull:
      return Vector2(0.5, 0.5);
    case UnitType.shatterer:
      return Vector2(0.4, 0.4);
    case UnitType.predator:
      return Vector2(0.75, 0.75);
    case UnitType.mlrs:
      return Vector2(0.6, 0.6);

    case UnitType.talon:
      return Vector2(0.6, 0.6);
    case UnitType.razorback:
      return Vector2(0.5, 0.5);
    case UnitType.orca:
      return Vector2(0.6, 0.6);
    case UnitType.mohawk:
      return Vector2(0.65, 0.65);
    case UnitType.hammerhead:
      return Vector2(0.5, 0.5);
  }
}
