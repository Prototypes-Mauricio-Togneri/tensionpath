import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/home/home_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/platform.dart';

class HomeScreen extends StatelessWidget {
  final HomeState state;

  const HomeScreen._(this.state);

  factory HomeScreen.instance() => HomeScreen._(HomeState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final HomeState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HomeState>(
      state: state,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopButtons(state),
          const Spacer(),
          Form(state),
          const Spacer(),
        ],
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  final HomeState state;

  const TopButtons(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        TopButton(icon: Icons.settings, onPressed: state.onSettings),
      ],
    );
  }
}

class Form extends StatelessWidget {
  final HomeState state;

  const Form(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HomeState>(
      state: state,
      builder: (context, state) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Deck(state),
            const VBox(30),
            PrimaryButton(
              label: 'Play',
              enabled: true,
              foregroundColor: Palette.PRIMARY,
              onPressed: state.onPlay,
            ),
            if (Platform.isMobile)
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: PrimaryButton(
                  label: 'Full screen',
                  enabled: true,
                  foregroundColor: Palette.PRIMARY,
                  onPressed: state.onFullscreen,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Deck extends StatelessWidget {
  final HomeState state;

  const Deck(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DeckRow(
          state: state,
          types: const [
            UnitType.riflemen,
            UnitType.shocks,
            UnitType.missiles,
            UnitType.grenadier,
            UnitType.sniper,
          ],
        ),
        const VBox(10),
        DeckRow(
          state: state,
          types: const [
            UnitType.rhino,
            UnitType.pitbull,
            UnitType.shatterer,
            UnitType.predator,
            UnitType.mlrs,
          ],
        ),
        const VBox(10),
        DeckRow(
          state: state,
          types: const [
            UnitType.talon,
            UnitType.razorback,
            UnitType.orca,
            UnitType.mohawk,
            UnitType.hammerhead,
          ],
        ),
      ],
    );
  }
}

class DeckRow extends StatelessWidget {
  final HomeState state;
  final List<UnitType> types;

  const DeckRow({
    required this.state,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final UnitType type in types) DeckCard(state: state, type: type),
      ],
    );
  }
}

class DeckCard extends StatelessWidget {
  final HomeState state;
  final UnitType type;

  const DeckCard({
    required this.state,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 20,
            color: Colors.red,
            child: Center(
              child: Text(
                type.name.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            height: 120,
            color: Colors.green,
            child: Image.asset(
              'assets/images/units/player_1/${type.clazz.name}/${type.name}.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 100,
            height: 33.33,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
