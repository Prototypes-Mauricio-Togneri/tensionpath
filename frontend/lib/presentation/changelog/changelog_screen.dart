import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/changelog/changelog_state.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/presentation/common/text/label.dart';
import 'package:tensionpath/utils/palette.dart';

class ChangelogScreen extends StatelessWidget {
  final ChangelogState state;

  const ChangelogScreen._(this.state);

  factory ChangelogScreen.instance() => ChangelogScreen._(ChangelogState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final ChangelogState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<ChangelogState>(
      state: state,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopButtons(state),
          Changes(state),
        ],
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  final ChangelogState state;

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

class Changes extends StatelessWidget {
  final ChangelogState state;

  const Changes(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SizedBox(
            width: 400,
            child: Label(
              text: state.text,
              color: Palette.TEXT_COLOR_PRIMARY,
              size: 14,
            ),
          ),
        ),
      ),
    );
  }
}
