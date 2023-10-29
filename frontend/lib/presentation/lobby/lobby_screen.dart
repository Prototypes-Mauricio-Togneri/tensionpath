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
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: BaseScreen(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const VBox(20),
              const Label(
                text: 'Waiting for players…',
                color: Palette.black,
                size: 14,
              ),
              StateProvider<LobbyState>(
                state: state,
                builder: (context, state) {
                  if (state.roomId.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Label(
                        text: 'Room ID: ${state.roomId}',
                        color: Palette.black,
                        size: 14,
                      ),
                    );
                  } else {
                    return const Empty();
                  }
                },
              ),
              const VBox(50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Palette.red),
                ),
                onPressed: state.onLeave,
                child: const Text('CANCEL'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
