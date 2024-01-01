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
    return Body(state);
  }
}

class Body extends StatelessWidget {
  final MainState state;

  const Body(this.state);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Center(
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
      ),
    );
  }
}

class Header extends StatelessWidget {
  final MainState state;

  const Header(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: state.onSettings,
          icon: const Icon(
            Icons.settings,
            color: Palette.grey,
            size: 25,
          ),
        ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  final MainState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*ElevatedButton(
          onPressed: state.pve,
          child: const Text('PvE'),
        ),
        const VBox(20),*/
        ElevatedButton(
          onPressed: state.pvp,
          child: const Text('PvP'),
        ),
      ],
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
