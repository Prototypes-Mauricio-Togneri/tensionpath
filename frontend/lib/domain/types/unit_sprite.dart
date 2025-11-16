import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

String cardUnitSprite(UnitType type) =>
    'assets/images/units/cards/${type.clazz.name}/${type.name}.png';

String matchUnitSprite({
  required UnitType type,
  required Player player,
}) => 'units/player_${player.index}/${type.clazz.name}/${type.name}.png';

double controlsUnitScale(UnitType type) => battlefieldUnitScale(type).x * 1.28;

Vector2 battlefieldUnitScale(UnitType type) {
  switch (type) {
    case UnitType.harvester:
      return Vector2(0.65, 0.65);

    case UnitType.riflemen:
      return Vector2(0.5, 0.5);
    case UnitType.shocks:
      return Vector2(0.45, 0.45);
    case UnitType.missiles:
      return Vector2(0.5, 0.5);
    case UnitType.grenadier:
      return Vector2(0.4, 0.4);
    case UnitType.sniper:
      return Vector2(0.5, 0.5);

    case UnitType.rhino:
      return Vector2(0.55, 0.55);
    case UnitType.pitbull:
      return Vector2(0.5, 0.5);
    case UnitType.shatterer:
      return Vector2(0.45, 0.45);
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
      return Vector2(0.8, 0.8);
    case UnitType.hammerhead:
      return Vector2(0.5, 0.5);

    case UnitType.wolverine:
      return Vector2(0.6, 0.6); // TODO(momo): adjust
    case UnitType.disruptor:
      return Vector2(0.5, 0.6); // TODO(momo): adjust
    case UnitType.zone:
      return Vector2(0.6, 0.6); // TODO(momo): adjust
    case UnitType.titan:
      return Vector2(0.8, 0.8); // TODO(momo): adjust
    case UnitType.mammoth:
      return Vector2(0.8, 0.8); // TODO(momo): adjust
  }
}
