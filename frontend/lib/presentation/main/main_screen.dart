import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/build/build_version.dart';
import 'package:tensionpath/domain/state/main/main_state.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/widgets/base_screen.dart';
import 'package:tensionpath/widgets/label.dart';

class MainScreen extends StatelessWidget {
  final MainState state;

  const MainScreen._(this.state);

  factory MainScreen.instance() => MainScreen._(MainState());

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Header(state),
          const Spacer(),
          Content(state),
          const Spacer(),
          const Footer(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final MainState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        onPressed: state.onSettings,
        icon: const Icon(
          Icons.settings,
          color: Palette.grey,
          size: 25,
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final MainState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<MainState>(
      state: state,
      builder: (context, state) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Undervoltage(state),
          ],
        ),
      ),
    );
  }
}

class Undervoltage extends StatelessWidget {
  final MainState state;

  const Undervoltage(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: state.onSelectPlayers,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: Colors.blue[500],
          selectedColor: Colors.white,
          fillColor: Colors.blue[200],
          color: Colors.blue[400],
          isSelected: state.selectedPlayers,
          children: const [
            PlayerSelectorEntry('2 Players'),
            PlayerSelectorEntry('3 Players'),
            PlayerSelectorEntry('4 Players'),
          ],
        ),
        const VBox(20),
        ElevatedButton(
          onPressed: state.onMatchmaking,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.bolt,
                size: 14,
                color: Palette.white,
              ),
              HBox(10),
              Text('Undervoltage'),
            ],
          ),
        ),
      ],
    );
  }
}

class PlayerSelectorEntry extends StatelessWidget {
  final String text;

  const PlayerSelectorEntry(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(text),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Label(
        text: 'Version $BUILD_VERSION',
        color: Palette.grey,
        size: 14,
      ),
    );
  }
}
