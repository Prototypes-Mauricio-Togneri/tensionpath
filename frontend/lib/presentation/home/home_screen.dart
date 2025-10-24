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
      child: Center(child: Form(state)),
    );
  }
}

class Form extends StatelessWidget {
  final HomeState state;

  const Form(this.state);

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
                Deck(
                  state: state,
                  cardHeight: constraints.maxHeight / 3.6,
                ),
                VBox(gap),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      label: 'Play',
                      enabled: state.isDeckFull,
                      foregroundColor: Palette.PRIMARY,
                      onPressed: state.onPlay,
                      fontSize: 20,
                      heigth: 40,
                    ),
                    VBox(gap),
                    PrimaryButton(
                      label: 'Units',
                      enabled: true,
                      foregroundColor: Palette.PRIMARY,
                      onPressed: state.onUnits,
                    ),
                    VBox(gap),
                    PrimaryButton(
                      label: 'Settings',
                      enabled: true,
                      foregroundColor: Palette.PRIMARY,
                      onPressed: state.onSettings,
                    ),
                    if (Platform.isMobile)
                      Padding(
                        padding: EdgeInsets.only(top: gap),
                        child: PrimaryButton(
                          label: 'Full screen',
                          enabled: true,
                          foregroundColor: Palette.PRIMARY,
                          onPressed: state.onFullscreen,
                        ),
                      ),
                    VBox(gap),
                    PrimaryButton(
                      label: 'Changelog',
                      enabled: true,
                      foregroundColor: Palette.PRIMARY,
                      onPressed: state.onChangelog,
                    ),
                    VBox(gap),
                    PrimaryButton(
                      label: 'Ping test',
                      enabled: true,
                      foregroundColor: Palette.PRIMARY,
                      onPressed: state.onPingTest,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Deck extends StatelessWidget {
  final HomeState state;
  final double cardHeight;

  const Deck({
    required this.state,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return DeckRow(
      state: state,
      types: state.deck,
      cardHeight: cardHeight,
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
