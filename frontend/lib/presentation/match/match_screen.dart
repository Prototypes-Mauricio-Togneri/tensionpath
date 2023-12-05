import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/label.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance(Battlefield battlefield) =>
      MatchScreen._(MatchState(battlefield));

  @override
  Widget build(BuildContext context) {
    return Body(state);
  }
}

class Body extends StatelessWidget {
  final MatchState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          StateProvider<MatchState>(
            state: state,
            builder: (context, state) => RotatedBox(
              quarterTurns: 2,
              child: Controls(
                state: state,
                player: state.gameState.enemy,
              ),
            ),
          ),
          Expanded(
            child: GameContent(state),
          ),
          StateProvider<MatchState>(
            state: state,
            builder: (context, state) => Controls(
              state: state,
              player: state.gameState.self,
            ),
          ),
        ],
      ),
    );
  }
}

class GameContent extends StatelessWidget {
  final MatchState state;

  const GameContent(this.state);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GameWidget(
        game: GameComponent(
          state: state.gameState,
          aspectRatio: constraints.maxWidth / constraints.maxHeight,
          pixelRatio: MediaQuery.of(context).devicePixelRatio,
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  final MatchState state;
  final Player player;

  const Controls({
    required this.state,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      color: Palette.green,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 5,
        right: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Label(
            text: player.credits.toInt().toString(),
            color: Palette.white,
            size: 12,
          ),
          for (int i = 1; i <= 10; i++)
            DeployButton(
              value: i,
              onPressed: () => state.onCreditsSelected(i),
              selected: state.gameState.creditsSelected == i,
            ),
        ],
      ),
    );
  }
}

class DeployButton extends StatelessWidget {
  final int value;
  final VoidCallback onPressed;
  final bool selected;

  const DeployButton({
    required this.value,
    required this.onPressed,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 25,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Palette.orange,
        borderRadius: const BorderRadius.all(Radius.circular(200)),
        border: Border.all(
          color: selected ? Palette.red : Palette.orange,
          width: 3,
        ),
      ),
      child: Material(
        color: Palette.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(200)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(200)),
          onTap: onPressed,
          child: Center(
            child: Label(
              text: value.toString(),
              color: Palette.white,
              weight: FontWeight.bold,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}
