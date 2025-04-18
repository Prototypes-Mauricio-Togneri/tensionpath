import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/splash/splash_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => state.onPlay('1'),
              child: const Text('PLAY AS PLAYER 1'),
            ),
            const VBox(20),
            ElevatedButton(
              onPressed: () => state.onPlay('2'),
              child: const Text('PLAY AS PLAYER 2'),
            ),
            const VBox(20),
            ElevatedButton(
              onPressed: state.onFullscreen,
              child: const Text('FULL SCREEN'),
            ),
            /*const VBox(20),
            ElevatedButton(
              onPressed: state.onCreateMatch,
              child: const Text('CREATE MATCH'),
            ),*/
          ],
        ),
      ),
    );
  }
}
