import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/splash/splash_state.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final SplashState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<SplashState>(
      state: state,
      builder: (context, state) => Center(
        child: state.newVersionAvailable
            ? Text(
                'New version available'.toUpperCase(),
                style: const TextStyle(color: Palette.SEMANTIC_ERROR),
              )
            : const CircularProgressIndicator(color: Palette.PRIMARY),
      ),
    );
  }
}
