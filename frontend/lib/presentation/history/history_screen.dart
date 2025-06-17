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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: state.pastMatches.map(PastMatch.new).toList()),
      ),
    );
  }
}

class PastMatch extends StatelessWidget {
  final Match match;

  const PastMatch(this.match);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PastTimeRow(
                label: 'Date:',
                value: Formatter.fullDateTime(match.createdAt),
              ),
              const VBox(5),
              PastTimeRow(
                label: 'Play time:',
                value:
                    '${Formatter.duration(match.playTime)} (${match.turn.turn} turns)',
              ),
              const VBox(5),
              PastTimeRow(
                label: 'Player 1:',
                value:
                    '${match.player1.name} (${match.player1.baseHealth > 0 ? 'winner' : 'loser'})',
              ),
              const VBox(5),
              PastTimeRow(
                label: 'Player 2:',
                value:
                    '${match.player2.name} (${match.player2.baseHealth > 0 ? 'winner' : 'loser'})',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PastTimeRow extends StatelessWidget {
  final String label;
  final String value;

  const PastTimeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Label(
          text: label,
          color: Palette.TEXT_COLOR_PRIMARY,
          size: 14,
          weight: FontWeight.bold,
        ),
        const HBox(10),
        Label(text: value, color: Palette.TEXT_COLOR_PRIMARY, size: 14),
      ],
    );
  }
}
