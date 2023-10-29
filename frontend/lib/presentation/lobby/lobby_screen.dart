import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/label.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance() => LobbyScreen._(LobbyState());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const VBox(20),
            Label(
              text: state.status,
              color: Palette.black,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
