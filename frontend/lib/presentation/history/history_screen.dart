import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/state/history/history_state.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/formatter.dart';
import 'package:tensionpath/utils/palette.dart';

class HistoryScreen extends StatelessWidget {
  final HistoryState state;

  const HistoryScreen._(this.state);

  factory HistoryScreen.instance() => HistoryScreen._(HistoryState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final HistoryState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HistoryState>(
      state: state,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TopButtons(state), Body(state)],
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  final HistoryState state;

  const TopButtons(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [TopButton(icon: Icons.arrow_back, onPressed: state.onClose)],
    );
  }
}

class Body extends StatelessWidget {
  final HistoryState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HistoryState>(
      state: state,
      builder: (context, state) {
        if (state.isLoading) {
          return const Loading();
        } else if (state.pastMatches.isEmpty) {
          return const NoPastMatches();
        } else {
          return PastMatches(state);
        }
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(child: CircularProgressIndicator(color: Palette.PRIMARY)),
    );
  }
}

class NoPastMatches extends StatelessWidget {
  const NoPastMatches();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Label(
          text: 'No past matches',
          color: Palette.TEXT_COLOR_SECONDARY,
          size: 16,
        ),
      ),
    );
  }
}

class PastMatches extends StatelessWidget {
  final HistoryState state;

  const PastMatches(this.state);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state.pastMatches.length,
      itemBuilder: (context, index) => PastMatch(state.pastMatches[index]),
    );
  }
}

class PastMatch extends StatelessWidget {
  final Match match;

  const PastMatch(this.match);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Label(
          text: 'Date: ${match.createdAt.toString()}',
          color: Palette.TEXT_COLOR_PRIMARY,
          size: 14,
        ),
        Label(
          text: 'Type: ${match.room.matchType}',
          color: Palette.TEXT_COLOR_PRIMARY,
          size: 14,
        ),
        Label(
          text: 'Play time: ${Formatter.hoursMinutes(match.playTime)}',
          color: Palette.TEXT_COLOR_PRIMARY,
          size: 14,
        ),
        Label(
          text: 'Turns: ${match.turn.turn}',
          color: Palette.TEXT_COLOR_PRIMARY,
          size: 14,
        ),
        Label(
          text:
              'Player 1: ${match.player1.name} (${match.player1.baseHealth > 0 ? 'winner' : 'loser'})',
          color: Palette.PLAYER_1,
          size: 14,
        ),
        Label(
          text:
              'Player 2: ${match.player2.name} (${match.player2.baseHealth > 0 ? 'winner' : 'loser'})',
          color: Palette.PLAYER_2,
          size: 14,
        ),
      ],
    );
  }
}
