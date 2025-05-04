import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance({
    required Room room,
    required String playerId,
  }) => LobbyScreen._(LobbyState(room: room, playerId: playerId));

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Waiting for players…',
              style: TextStyle(color: Colors.white),
            ),
            const VBox(20),
            Text(state.room.id, style: const TextStyle(color: Colors.white)),
            const VBox(20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
