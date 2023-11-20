import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/game_component.dart';
import 'package:tensionpath/domain/state/main/main_state.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/label.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return Body(state);
  }
}

class Body extends StatelessWidget {
  final MainState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        children: [
          Expanded(
            child: GameContent(state),
          ),
          StateProvider<MainState>(
            state: state,
            builder: (context, state) => Controls(state),
          ),
        ],
      ),
    );
  }
}

class GameContent extends StatelessWidget {
  final MainState state;

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
  final MainState state;

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
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Palette.orange,
          border: Border.all(
            color: selected ? Palette.red : Palette.orange,
            width: 3,
          ),
        ),
        height: 35,
        child: Material(
          color: Palette.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Center(
              child: Label(
                text: value.toString(),
                color: Palette.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
