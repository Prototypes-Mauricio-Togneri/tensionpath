import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/nodes/node_accumulator_component.dart';
import 'package:tensionpath/domain/state/game/game_state.dart';
import 'package:tensionpath/extensions/canvas_extension.dart';
import 'package:tensionpath/utils/palette.dart';

class NodeChestComponent extends NodeAccumulatorComponent with TapCallbacks {
  NodeChestComponent({
    required super.node,
    required super.position,
    required super.size,
    super.owner,
  }) : super(rate: Constants.NODE_CHEST_CAPTURE_RATE);

  void onAcquired() {
    GameState.instance.onAddCredits(
      player: owner!,
      credits: creditsAccumulated,
    );

    removeAccumulated(creditsAccumulated);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if (hasOwner && hasCreditsAccumulated) {
      onAcquired();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawText(
      text: creditsAccumulated.toString(),
      position: size / 2,
      size: 70,
      color: Palette.yellow,
    );
  }
}
