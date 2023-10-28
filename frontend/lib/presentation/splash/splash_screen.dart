import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/splash/splash_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: ElevatedButton(
          onPressed: state.onMatchmaking,
          child: const Text('FIGHT!'),
        ),
      ),
    );
  }
}
