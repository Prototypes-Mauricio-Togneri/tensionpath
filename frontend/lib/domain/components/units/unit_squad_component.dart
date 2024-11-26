import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/units/unit_shooter_component.dart';
import 'package:tensionpath/domain/state/game/units/unit_squad.dart';

class UnitSquadComponent extends UnitShooterComponent<UnitSquad> {
  final Paint borderPaint = Paint();

  UnitSquadComponent({
    required super.unit,
    required super.size,
  });

  @override
  FutureOr onLoad() {
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.color = unit.color;
    borderPaint.strokeWidth = size.y / 12;

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    final double memberSize = width / 4;

    _drawMember(
      canvas: canvas,
      position: Offset(width / 2, memberSize / 2),
      size: Size(memberSize, memberSize),
    );

    _drawMember(
      canvas: canvas,
      position: Offset(width / 2, height - (memberSize / 2)),
      size: Size(memberSize, memberSize),
    );

    _drawMember(
      canvas: canvas,
      position: Offset(memberSize / 2, height / 2),
      size: Size(memberSize, memberSize),
    );

    _drawMember(
      canvas: canvas,
      position: Offset(width - (memberSize / 2), height / 2),
      size: Size(memberSize, memberSize),
    );

    super.render(canvas);
  }

  void _drawMember({
    required Canvas canvas,
    required Offset position,
    required Size size,
  }) {
    canvas.drawRect(
      Rect.fromCenter(
        center: position,
        width: size.width,
        height: size.height,
      ),
      borderPaint,
    );

    canvas.drawLine(
      position,
      position.translate(0, -(size.height / 2)),
      borderPaint,
    );
  }
}
