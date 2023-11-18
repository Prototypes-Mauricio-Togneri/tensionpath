import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/unit.dart';

class Node {
  final String id;
  final Vector2 position;
  Unit? unit;

  Node({
    required this.id,
    required this.position,
  });

  bool get isEmpty => unit == null;

  void linkUnit(Unit newUnit) {
    if (isEmpty) {
      unit = newUnit;
    }
  }

  void unlinkUnit() {
    unit = null;
  }

  bool isAligned(Unit unit) => (position - unit.position).length < 1;
}
