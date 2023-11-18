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

  bool get isEmpty => lockedUnit == null;

  void lockUnit(Unit unit) {
    if (isEmpty) {
      lockedUnit = unit;
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
