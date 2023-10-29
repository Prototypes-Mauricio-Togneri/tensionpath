import 'package:dafluta/dafluta.dart';
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
        child: StateProvider<SplashState>(
          state: state,
          builder: (context, state) {
            if (state.userLoggedIn) {
              return ElevatedButton(
                onPressed: state.onMatchmaking,
                child: const Text('FIGHT!'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
