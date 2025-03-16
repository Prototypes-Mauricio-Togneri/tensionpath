import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/components/units/unit_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/nodes/node.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';
import 'package:tensionpath/domain/state/game/units/unit.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/utils/navigation.dart';
import 'package:tensionpath/utils/palette.dart';

class GameComponent extends FlameGame {
  final MatchState matchState;
  final Player self;
  final Player enemy;
  final Battlefield battlefield;

  GameComponent({
    required this.matchState,
    required this.self,
    required this.enemy,
    required this.battlefield,
  }) : super(world: MatchComponent(self: self, battlefield: battlefield)) {
    GameComponentRef.instance = this;
  }

  @override
  FutureOr onLoad() {
    debugMode = false;

    camera = CameraComponent.withFixedResolution(
      height: Constants.SCREEN_HEIGHT,
      width: Constants.SCREEN_WIDTH,
    );

    camera.moveTo(
      Vector2(Constants.SCREEN_WIDTH / 2, Constants.SCREEN_HEIGHT / 2),
    );

    if (debugMode) {
      add(FpsTextComponent());
    }

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Palette.GAME_BACKGROUND;

  Iterable<UnitComponent> get unitComponents =>
      world.children.whereType<UnitComponent>();

  void onUnitCreated(Unit unit) {
    world.add(unit.component);
  }

  void onUnitDestroyed(Unit unit) {
    unit.destroy();

    for (final UnitComponent unitComponent in unitComponents) {
      if (unitComponent.unit == unit) {
        world.remove(unitComponent);
        break;
      }
    }
  }

  void onNodeVictoryCaptured(Node node) => onMatchFinished(true);

  void onSpawnUnit({
    required Player player,
    required Node node,
    required UnitType unitType,
  }) {
    /*final double extraGap =
        -player.ownershipDirection * (battlefield.nodeSize / 2);
    final Vector2 startingPosition = Vector2.copy(nodes.first.position);
    startingPosition.add(Vector2(0, extraGap));

    final Unit unit = Unit.fromType(
      unitType: unitType,
      owner: player,
      lane: lane,
      nodes: nodes.sublist(1, nodes.length),
      startingPosition: startingPosition,
      nodeSize: battlefield.nodeSize,
    );

    onUnitCreated(unit);*/
  }

  @override
  void update(double dt) {
    super.update(dt);

    self.update(dt);
    enemy.update(dt);
    battlefield.update(dt);
  }

  void onMatchFinished(bool won) {
    pauseEngine();

    if (won) {
      ConfirmationDialog.won(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    } else {
      ConfirmationDialog.lost(onAccept: _onMatchReset, onCancel: _onMatchQuit);
    }
  }

  void _onMatchReset() => matchState.restart();

  void _onMatchQuit() => Navigation.pop();
}

mixin GameComponentRef {
  static late GameComponent instance;

  GameComponent get game => instance;
}
