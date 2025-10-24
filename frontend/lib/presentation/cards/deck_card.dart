import 'package:flutter/material.dart';
import 'package:tensionpath/domain/types/unit_class.dart';
import 'package:tensionpath/domain/types/unit_sprite.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/utils/palette.dart';

class DeckCard extends StatelessWidget {
  final UnitType unitType;
  final double cardHeight;
  final Function(UnitType) onCardSelected;
  final bool Function(UnitType) isSelected;

  const DeckCard({
    required this.unitType,
    required this.cardHeight,
    required this.onCardSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: unitType.stats,
      child: GestureDetector(
        onTap: () => onCardSelected(unitType),
        child: Container(
          margin: EdgeInsets.all(cardHeight / 20),
          height: cardHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected(unitType)
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
                    if (isSelected(unitType))
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
