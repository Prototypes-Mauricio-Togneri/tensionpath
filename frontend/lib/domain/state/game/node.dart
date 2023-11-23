import 'package:flame/components.dart';

class Node {
  final String id;
  final Vector2 position;

  Node({
    required this.id,
    required this.position,
  });

  /*void onUnitEnter(Unit unit) {
    if (lockedUnit == null) {
      lockedUnit = unit;
    } else {
      lockedUnit?.merge(unit);
      unit.destroy();
    }
  }*/

  void onSelect() {
    /*if (lockedUnit != null) {
      lockedUnit = null;
    }*/
  }
}
