import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/game/game.dart';
import 'package:tensionpath/domain/state/main/main_state.dart';

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
    return DarkStatusBar(
      child: Scaffold(
          body: GameWidget(
        game: FixedResolutionExample(),
      )),
    );
  }
}
