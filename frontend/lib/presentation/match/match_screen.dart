import 'package:dafluta/dafluta.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance({
    required String host,
    required String matchId,
    required String selfId,
  }) => MatchScreen._(
    MatchState(
      host: host,
      matchId: matchId,
      selfId: selfId,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return OnClose(
      onClose: state.onOpenMenu,
      child: GameContainer(
        child: StateProvider<MatchState>(
          state: state,
          builder: (context, state) =>
              state.isLoading ? const Loading() : Content(state),
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Palette.PRIMARY,
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
