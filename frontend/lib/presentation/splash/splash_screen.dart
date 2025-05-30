import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/splash/splash_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return const GameContainer(
      child: Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }
}
