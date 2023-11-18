import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/game_container.dart';
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
    return StateProvider<MainState>(
      state: state,
      builder: (context, state) => Body(state),
    );
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
          Controls(state),
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
        game: GameContainer(
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
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 1; i <= 10; i++)
            DeployButton(
              value: i,
              onPressed: () => state.onDeployUnits(i),
            ),
        ],
      ),
    );
  }
}

class DeployButton extends StatelessWidget {
  final int value;
  final VoidCallback onPressed;

  const DeployButton({
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        color: Palette.red,
        height: 40,
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
