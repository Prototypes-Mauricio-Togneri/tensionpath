import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/reconfigurable.dart';
import 'package:tensionpath/domain/entities/missile.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/platform.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/structures/structure_missile.dart';
import 'package:tensionpath/domain/entities/structures/structure_pad.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/types/priority.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/extensions/component_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class StructureComponent extends PositionComponent implements Reconfigurable {
  final Node node;
  final Paint outterPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint innerPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint emptyPaint = Palette.paint(
    color: Palette.NODE_EMPTY_BACKGROUND,
    style: PaintingStyle.fill,
  );
  final Paint fogPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.NODE_FOG,
  );
  Platform? platform;

  StructureComponent({
    required this.node,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.node.value);

  @override
  FutureOr onLoad() async {
    if (match.match.self.isPlayer2) {
      angle = pi;
    }

    reconfigure();

    if ((node.hasStructure) && (node.structure is StructureMissile)) {
      add(
        MissileIndicatorComponent(
          missile: match.match.battlefield.missile,
          position: size / 2,
          size: Vector2(size.x * 0.7, size.y * 0.08),
        ),
      );
    }

    return super.onLoad();
  }

  @override
  void reconfigure() {
    if (node.hasStructure) {
      final Structure structure = node.structure!;

      if (structure is StructureLauncher) {
        if (structure.player.isPlayer1) {
          innerPaint.color = Palette.NODE_LAUNCHER_1_BACKGROUND;
          outterPaint.color = Palette.NODE_LAUNCHER_1_BORDER;
        } else if (structure.player.isPlayer2) {
          innerPaint.color = Palette.NODE_LAUNCHER_2_BACKGROUND;
          outterPaint.color = Palette.NODE_LAUNCHER_2_BORDER;
        }
      } else if (structure is StructureMissile) {
        innerPaint.color = Palette.NODE_MISSILE_BACKGROUND;
        outterPaint.color = Palette.NODE_MISSILE_BORDER;
      } else if (structure is StructurePad) {
        platform =
            platform ??
            match.match.battlefield.platformById(structure.platformId);

        innerPaint.color = Palette.NODE_PAD_BACKGROUND;

        if (platform!.owner == Constants.PLAYER_1) {
          outterPaint.color = Palette.PLAYER_1;
        } else if (platform!.owner == Constants.PLAYER_2) {
          outterPaint.color = Palette.PLAYER_2;
        } else if (platform!.owner == '') {
          outterPaint.color = Palette.NODE_PAD_CONTESTED_BORDER;
        } else if (platform!.owner == null) {
          outterPaint.color = Palette.NODE_PAD_NEUTRAL_BORDER;
        }
      } else if (structure is StructureResources) {
        innerPaint.color = Palette.NODE_RESOURCES_BACKGROUND;
        outterPaint.color = Palette.NODE_RESOURCES_BORDER;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    const double sizeFactor = 0.97;

    if (node.hasStructure) {
      _renderStructure(
        structure: node.structure!,
        position: size / 2,
        size: size * sizeFactor,
        canvas: canvas,
      );
    } else {
      canvas.drawHexagon(
        center: size / 2,
        size: size * sizeFactor,
        paint: emptyPaint,
      );
    }

    if (!node.isRevealed) {
      canvas.drawHexagon(
        center: size / 2,
        size: size * sizeFactor,
        paint: fogPaint,
      );
    }

    /*canvas.drawText(
      text: node.location.toString(),
      color: Palette.DEBUG_TEXT,
      position: Vector2(size.x / 2, size.y * 0.87),
      size: size.x / 10,
      angle: match.match.self.isPlayer2 ? pi : 0,
    );*/
    /*canvas.drawText(
      text:
          '${absolutePosition.x.toInt()}, '
          '${absolutePosition.y.toInt()}',
      color: Palette.DEBUG_TEXT,
      position: Vector2(size.x / 2, size.y / 2),
      size: size.x / 7,
    );*/
  }

  void _renderStructure({
    required Structure structure,
    required Vector2 position,
    required Vector2 size,
    required Canvas canvas,
  }) {
    canvas.drawStructureHexagon(
      position: position,
      size: size,
      outterPaint: outterPaint,
      innerPaint: innerPaint,
    );
  }
}

class MissileIndicatorComponent extends PositionComponent
    implements Reconfigurable {
  final Missile missile;
  final Paint backgroundPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_BACKGROUND,
  );
  final Paint foregroundPaint = Palette.paint(style: PaintingStyle.fill);
  final Paint placeholderPaint = Palette.paint(
    style: PaintingStyle.fill,
    color: Palette.MISSILE_INDICATOR_PLACEHOLDER,
  );

  MissileIndicatorComponent({
    required this.missile,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center);

  @override
  FutureOr onLoad() async {
    reconfigure();

    return super.onLoad();
  }

  @override
  void reconfigure() {
    final String? owner = missile.owner;

    if (owner == null) {
      foregroundPaint.color = Palette.MISSILE_OWNER_NONE;
    } else if (owner == '') {
      foregroundPaint.color = Palette.MISSILE_OWNER_CONTESTED;
    } else if (owner == Constants.PLAYER_1) {
      foregroundPaint.color = Palette.PLAYER_1;
    } else if (owner == Constants.PLAYER_2) {
      foregroundPaint.color = Palette.PLAYER_2;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), backgroundPaint);

    final double gap = size.x / 80;
    final double blockSize =
        (width - gap * (missile.maxCharge + 1)) / missile.maxCharge;

    for (int i = 0; i < missile.charge; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        foregroundPaint,
      );
    }

    for (int i = missile.charge; i < missile.maxCharge; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          gap + (blockSize + gap) * i,
          gap,
          blockSize,
          height - (gap * 2),
        ),
        placeholderPaint,
      );
    }
  }
}
