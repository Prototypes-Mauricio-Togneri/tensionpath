import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
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
          Expanded(
            child: GameContent(state),
          ),
          StateProvider<MatchState>(
            state: state,
            builder: (context, state) => Controls(state),
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

  const Controls(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          for (int i = 1; i <= 10; i++)
            DeployButton(
              value: i,
              onPressed: () => state.onCommandPointsSelected(i),
              selected: state.gameState.commandPointsSelected == i,
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
      height: 30,
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
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
