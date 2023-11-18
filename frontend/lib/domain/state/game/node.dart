import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

class Node {
  final String id;
  final Vector2 position;
  Unit? lockedUnit;

  Node({
    required this.id,
    required this.position,
  });

  void onUnitEnter(Unit unit) {
    if (lockedUnit == null) {
      lockedUnit = unit;
    } else {
      lockedUnit?.merge(unit);
    }
  }

  void onSelect() {
    if (lockedUnit != null) {
      lockedUnit?.unlock();
      lockedUnit = null;
    }
  }

  bool isAligned(Unit unit) => (position - unit.position).length < 1;
}
