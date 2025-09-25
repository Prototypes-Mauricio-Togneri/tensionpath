import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/assets.dart';

String unitSprite(UnitType type) {
  switch (type) {
    case UnitType.harvester:
      return Assets.IMAGES_UNITS_HARVESTER;
    case UnitType.plant_1:
      return Assets.IMAGES_UNITS_PLANT_1;
    case UnitType.plant_2:
      return Assets.IMAGES_UNITS_PLANT_2;
    case UnitType.plant_3:
      return Assets.IMAGES_UNITS_PLANT_3;
    case UnitType.water_1:
      return Assets.IMAGES_UNITS_WATER_1;
    case UnitType.water_2:
      return Assets.IMAGES_UNITS_WATER_2;
    case UnitType.water_3:
      return Assets.IMAGES_UNITS_WATER_3;
    case UnitType.flame_1:
      return Assets.IMAGES_UNITS_FLAME_1;
    case UnitType.flame_2:
      return Assets.IMAGES_UNITS_FLAME_2;
    case UnitType.flame_3:
      return Assets.IMAGES_UNITS_FLAME_3;
  }
}
