import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/home/home_state.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        TopButtons(state),
        Expanded(child: Form(state)),
        const VBox(20),
      ],
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
    print(MediaQuery.of(context).size.height);
    return LayoutBuilder(
      builder: (context, constraints) {
        return StateProvider<HomeState>(
          state: state,
          builder: (context, state) => Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Deck(
                state: state,
                cardHeight: constraints.maxHeight / 3.5,
              ),
              const VBox(30),
              PrimaryButton(
                label: 'Play',
                enabled: state.isDeckFull,
                foregroundColor: Palette.PRIMARY,
                onPressed: state.onPlay,
              ),
              if (Platform.isMobile)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: PrimaryButton(
                    label: 'Full screen',
                    enabled: true,
                    foregroundColor: Palette.PRIMARY,
                    onPressed: state.onFullscreen,
                  ),
                ),
            ],
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
          cardHeight: cardHeight,
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
          cardHeight: cardHeight,
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
          cardHeight: cardHeight,
        ),
      ],
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
              state: state,
              unitType: type,
              cardHeight: cardHeight,
            ),
        ],
      ),
    );
  }
}

class DeckCard extends StatelessWidget {
  final HomeState state;
  final UnitType unitType;
  final double cardHeight;

  const DeckCard({
    required this.state,
    required this.unitType,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: unitType.stats,
      child: GestureDetector(
        onTap: () => state.onCardSelected(unitType),
        child: Container(
          margin: const EdgeInsets.all(10),
          height: cardHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: state.isSelected(unitType)
                  ? Palette.CARD_SELECTED
                  : Palette.CARD_UNSELECTED,
              width: 5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double innerHeight = constraints.maxHeight;
                final double imageHeight = innerHeight * 0.7;
                final double cardWidth = imageHeight / 1.2;
                final double counterHeight = cardWidth / 3;
                final double headerHeight =
                    innerHeight - imageHeight - counterHeight;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: cardWidth,
                      height: headerHeight,
                      color: Palette.GAME_BACKGROUND,
                      child: Center(
                        child: Text(
                          unitType.name.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (state.isSelected(unitType))
                      SelectedCard(
                        unitType: unitType,
                        cardHeight: imageHeight,
                      )
                    else
                      UnselectedCard(
                        unitType: unitType,
                        cardHeight: imageHeight,
                      ),
                    SizedBox(
                      width: cardWidth,
                      height: counterHeight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Counter(
                            unitClass: UnitClass.infantry,
                            value: unitType.counterAgainst(UnitClass.infantry),
                            size: counterHeight,
                          ),
                          Counter(
                            unitClass: UnitClass.vehicle,
                            value: unitType.counterAgainst(UnitClass.vehicle),
                            size: counterHeight,
                          ),
                          Counter(
                            unitClass: UnitClass.aircraft,
                            value: unitType.counterAgainst(UnitClass.aircraft),
                            size: counterHeight,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class UnselectedCard extends StatelessWidget {
  final UnitType unitType;
  final double cardHeight;

  const UnselectedCard({
    required this.unitType,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardHeight / 1.2,
      height: cardHeight,
      child: ColorFiltered(
        colorFilter: const ColorFilter.matrix([
          0.2126, 0.7152, 0.0722, 0, 0, // Red channel
          0.2126, 0.7152, 0.0722, 0, 0, // Green channel
          0.2126, 0.7152, 0.0722, 0, 0, // Blue channel
          0, 0, 0, 1, 0, // Alpha channel
        ]),
        child: Image.asset(
          cardUnitSprite(unitType),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SelectedCard extends StatelessWidget {
  final UnitType unitType;
  final double cardHeight;

  const SelectedCard({
    required this.unitType,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardHeight / 1.2,
      height: cardHeight,
      child: Image.asset(
        cardUnitSprite(unitType),
        fit: BoxFit.contain,
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final UnitClass unitClass;
  final int value;
  final double size;

  const Counter({
    required this.unitClass,
    required this.value,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        'assets/images/units/counter/${unitClass.name}_$_indicator.png',
        fit: BoxFit.contain,
      ),
    );
  }

  String get _indicator {
    if (value > 0) {
      return 'good';
    } else if (value < 0) {
      return 'bad';
    } else {
      return 'normal';
    }
  }
}
