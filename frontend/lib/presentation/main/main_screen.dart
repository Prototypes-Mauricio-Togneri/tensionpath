import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/main/main_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

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
