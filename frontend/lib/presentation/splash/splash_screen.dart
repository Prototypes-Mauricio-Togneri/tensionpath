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
      child: LayoutBuilder(
        builder: (context, constraints) {
          state.setSize(Size(constraints.maxWidth, constraints.maxHeight));

          return Center(
            child: ElevatedButton(
              onPressed: state.onPlay,
              child: const Text('PLAY'),
            ),
          );
        },
      ),
    );
  }
}
