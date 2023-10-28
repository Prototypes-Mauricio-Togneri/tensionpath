import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionbase/domain/state/splash/splash_state.dart';

class SplashScreen extends StatelessWidget {
  final SplashState state;

  const SplashScreen._(this.state);

  factory SplashScreen.instance() => SplashScreen._(SplashState());

  @override
  Widget build(BuildContext context) {
    return const Empty();
  }
}
