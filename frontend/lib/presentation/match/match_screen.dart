import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance({
    required String matchId,
    required String selfId,
  }) => MatchScreen._(MatchState(matchId: matchId, selfId: selfId));

  @override
  Widget build(BuildContext context) {
    return OnClose(
      onClose: state.onClose,
      child: GameContainer(
        child: StateProvider<MatchState>(
          state: state,
          builder: (context, state) =>
              state.isInitialized ? Content(state) : const Empty(),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MatchState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: state.gameComponent!);
  }
}
