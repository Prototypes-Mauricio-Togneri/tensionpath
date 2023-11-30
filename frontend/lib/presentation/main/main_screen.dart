import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/main/main_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return Body(state);
  }
}

class Body extends StatelessWidget {
  final MainState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: state.onStart3Lanes,
              child: const Text('3 lanes'),
            ),
            const VBox(20),
            ElevatedButton(
              onPressed: state.onStart5Lanes,
              child: const Text('5 lanes'),
            ),
          ],
        ),
      ),
    );
  }
}
