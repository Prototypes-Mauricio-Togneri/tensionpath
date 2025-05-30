import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance(String roomId) =>
      LobbyScreen._(LobbyState(roomId));

  @override
  Widget build(BuildContext context) {
    return const GameContainer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Waiting for players…', style: TextStyle(color: Colors.white)),
            VBox(20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
