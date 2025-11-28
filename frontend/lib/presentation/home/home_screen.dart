import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/home/home_state.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/cards/deck_card.dart';
import 'package:tensionpath/presentation/common/buttons/primary_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';
import 'package:tensionpath/utils/platform.dart';

class HomeScreen extends StatelessWidget {
  final HomeState state;

  const HomeScreen._(this.state);

  factory HomeScreen.instance() => HomeScreen._(HomeState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Center(
        child: Platform.isMobile ? FormMobile(state) : FormDesktop(state),
      ),
    );
  }
}

class FormDesktop extends StatelessWidget {
  final HomeState state;

  const FormDesktop(this.state);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double gap = constraints.maxHeight / 40;

        return StateProvider<HomeState>(
          state: state,
          builder: (context, state) => Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                VBox(gap),
                DeckRow(
                  state: state,
                  types: state.deck,
                  cardHeight: constraints.maxHeight / 3.6,
                ),
                VBox(gap),
                ButtonsSection(
                  state: state,
                  gap: gap,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FormMobile extends StatelessWidget {
  final HomeState state;

  const FormMobile(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<HomeState>(
      state: state,
      builder: (context, state) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DeckRow(
                          state: state,
                          types: state.deck.sublist(0, 3),
                          cardHeight: constraints.maxHeight / 2.1,
                        ),
                        DeckRow(
                          state: state,
                          types: state.deck.sublist(3, 6),
                          cardHeight: constraints.maxHeight / 2.1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 100,
              left: 20,
            ),
            child: ButtonsSection(
              state: state,
              gap: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class DeckRow extends StatelessWidget {
  final HomeState state;
  final List<UnitType> types;
  final double cardHeight;

  const DeckRow({
    required this.state,
    required this.types,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final UnitType type in types)
            DeckCard(
              unitType: type,
              cardHeight: cardHeight,
              onCardSelected: (type) {},
              isSelected: (type) => true,
            ),
        ],
      ),
    );
  }
}

class ButtonsSection extends StatelessWidget {
  final HomeState state;
  final double gap;

  const ButtonsSection({
    required this.state,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          label: 'Play',
          enabled: state.isDeckFull,
          backgroundColor: Palette.PRIMARY,
          onPressed: state.onPlay,
        ),
        VBox(gap),
        PrimaryButton(
          label: 'Units',
          enabled: true,
          backgroundColor: Palette.PRIMARY,
          onPressed: state.onUnits,
        ),
        VBox(gap),
        PrimaryButton(
          label: 'Settings',
          enabled: true,
          backgroundColor: Palette.PRIMARY,
          onPressed: state.onSettings,
        ),
        if (Platform.isMobile)
          Padding(
            padding: EdgeInsets.only(top: gap),
            child: PrimaryButton(
              label: 'Full screen',
              enabled: true,
              backgroundColor: Palette.PRIMARY,
              onPressed: state.onFullscreen,
            ),
          ),
        VBox(gap),
        PrimaryButton(
          label: 'Changelog',
          enabled: true,
          backgroundColor: Palette.PRIMARY,
          onPressed: state.onChangelog,
        ),
        VBox(gap),
        PrimaryButton(
          label: 'Ping test',
          enabled: true,
          backgroundColor: Palette.PRIMARY,
          onPressed: state.onPingTest,
        ),
      ],
    );
  }
}
