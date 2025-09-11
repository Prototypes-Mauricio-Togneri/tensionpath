import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/lobby/lobby_state.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/palette.dart';

class LobbyScreen extends StatelessWidget {
  final LobbyState state;

  const LobbyScreen._(this.state);

  factory LobbyScreen.instance() => LobbyScreen._(LobbyState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: Content(state),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final LobbyState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<LobbyState>(
      state: state,
      builder: (context, state) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Label(
            text: 'Waiting for opponent…',
            size: 14,
            color: Palette.TEXT_COLOR_PRIMARY,
          ),
          const VBox(20),
          const CircularProgressIndicator(color: Palette.PRIMARY),
          const VBox(40),
          PrimaryButton(
            label: 'Cancel',
            enabled: !state.isLoading && !state.canceling,
            foregroundColor: Palette.SEMANTIC_ERROR,
            onPressed: state.onCancel,
          ),
        ],
      ),
    );
  }
}
