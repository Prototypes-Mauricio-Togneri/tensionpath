import 'dart:ui';
import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/units.dart';
import 'package:tensionpath/domain/types/priority.dart';

class UnitsComponent extends PositionComponent {
  final Units units;
  final Node node;

  UnitsComponent({
    required this.units,
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.unit.value);

  @override
  void render(Canvas canvas) {
    final Paint paint =
        Paint()
          ..color = units.player.color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, paint);
  }
}
