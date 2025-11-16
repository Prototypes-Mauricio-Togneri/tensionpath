import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

enum NodeType {
  empty,
  resources,
  building,
  pad,
  rocks_low,
  missile
  ;

  bool canMove(UnitType type) {
    if ((type.clazz == UnitClass.harvester) ||
        (type.clazz == UnitClass.infantry) ||
        (type.clazz == UnitClass.vehicle)) {
      return [
        empty,
        resources,
        pad,
      ].contains(this);
    } else if (type.clazz == UnitClass.aircraft) {
      return [
        empty,
        resources,
        pad,
        rocks_low,
      ].contains(this);
    } else {
      return false;
    }
  }
}
