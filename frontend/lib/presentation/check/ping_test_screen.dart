import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/check/ping_test_state.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/palette.dart';

class PingTestScreen extends StatelessWidget {
  final PingStateState state;

  const PingTestScreen._(this.state);

  factory PingTestScreen.instance() => PingTestScreen._(PingStateState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final PingStateState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopButtons(state),
        const Spacer(),
        Form(state),
        const Spacer(),
      ],
    );
  }
}

class TopButtons extends StatelessWidget {
  final PingStateState state;

  const TopButtons(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TopButton(
          icon: Icons.arrow_back,
          onPressed: state.onClose,
        ),
      ],
    );
  }
}

class Form extends StatelessWidget {
  final PingStateState state;

  const Form(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<PingStateState>(
      state: state,
      builder: (context, state) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.isRunning)
              Label(
                text: state.result,
                color: Palette.TEXT_COLOR_PRIMARY,
                size: 16,
              ),
            const VBox(20),
            if (!state.isRunning)
              PrimaryButton(
                label: 'Start',
                enabled: true,
                foregroundColor: Palette.PRIMARY,
                onPressed: state.onStart,
              )
            else
              PrimaryButton(
                label: 'Stop',
                enabled: true,
                foregroundColor: Palette.SEMANTIC_ERROR,
                onPressed: state.onStop,
              ),
          ],
        ),
      ),
    );
  }
}
