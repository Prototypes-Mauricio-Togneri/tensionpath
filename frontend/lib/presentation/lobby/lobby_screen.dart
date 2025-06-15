import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/room.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/palette.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance(Room room) => LobbyScreen._(LobbyState(room));

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Label(
              text: 'Waiting for players…',
              size: 14,
              color: Palette.TEXT_COLOR_PRIMARY,
            ),
            const VBox(20),
            const CircularProgressIndicator(color: Palette.PRIMARY),
            const VBox(40),
            PrimaryButton(
              label: 'Cancel',
              enabled: true,
              foregroundColor: Palette.SEMANTIC_ERROR,
              onPressed: state.onCancel,
            ),
          ],
        ),
      ),
    );
  }
}
