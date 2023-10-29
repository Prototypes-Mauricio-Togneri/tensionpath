import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance() => LobbyScreen._(LobbyState());

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
