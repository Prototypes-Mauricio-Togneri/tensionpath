import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/state/units/units_state.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/presentation/common/buttons/top_button.dart';
import 'package:tensionpath/presentation/common/container/game_container.dart';
import 'package:tensionpath/utils/palette.dart';

class UnitsScreen extends StatelessWidget {
  final UnitsState state;

  const UnitsScreen._(this.state);

  factory UnitsScreen.instance() => UnitsScreen._(UnitsState());

  @override
  Widget build(BuildContext context) {
    return GameContainer(child: Content(state));
  }
}

class Content extends StatelessWidget {
  final UnitsState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    return StateProvider<UnitsState>(
      state: state,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopButtons(state),
          Form(state),
        ],
      ),
    );
  }
}

class TopButtons extends StatelessWidget {
  final UnitsState state;

  const TopButtons(this.state);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [TopButton(icon: Icons.arrow_back, onPressed: state.onClose)],
    );
  }
}

class Form extends StatelessWidget {
  final UnitsState state;

  const Form(this.state);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double gap = constraints.maxHeight / 30;

          return StateProvider<UnitsState>(
            state: state,
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Deck(
                  state: state,
                  cardHeight: (constraints.maxHeight - gap) / 3,
                ),
                VBox(gap),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Deck extends StatelessWidget {
  final UnitsState state;
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
  final UnitsState state;
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
  final UnitsState state;
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
          margin: EdgeInsets.all(cardHeight / 20),
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
                          style: TextStyle(
                            color: Palette.TEXT_COLOR_TERTIARY,
                            fontSize: headerHeight / 2,
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
  final String value;
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
        'assets/images/units/counter/${unitClass.name}_$value.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
