import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/history/history_state.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';

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
        children: [TopButtons(state), const Spacer()],
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
