import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionbase/domain/state/game/game_state.dart';
import 'package:tensionbase/utils/palette.dart';
import 'package:tensionbase/widgets/base_screen.dart';
import 'package:tensionbase/widgets/label.dart';

class GameScreen extends StatelessWidget {
  final GameState state;

  const GameScreen._(this.state);

  factory GameScreen.instance() => GameScreen._(GameState());

  @override
  Widget build(BuildContext context) {
    return StateProvider<GameState>(
      state: state,
      builder: (context, state) => Body(state),
    );
  }
}

class Body extends StatelessWidget {
  final GameState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      child: Center(
        child: Label(
          text: 'YES!',
          color: Palette.black,
          size: 14,
        ),
      ),
    );
  }
}
