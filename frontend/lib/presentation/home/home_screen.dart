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
        for (final UnitType type in types)
          DeckCard(state: state, unitType: type),
      ],
    );
  }
}

class DeckCard extends StatelessWidget {
  final HomeState state;
  final UnitType unitType;

  const DeckCard({
    required this.state,
    required this.unitType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => state.onCardSelected(unitType),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: state.isSelected(unitType)
                ? Palette.CARD_SELECTED
                : Palette.CARD_UNSELECTED,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 20,
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
                SelectedCard(unitType)
              else
                UnselectedCard(unitType),
              SizedBox(
                width: 100,
                height: 33.33,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Counter(
                      unitClass: UnitClass.infantry,
                      value: unitType.counterAgainst(UnitClass.infantry),
                    ),
                    Counter(
                      unitClass: UnitClass.vehicle,
                      value: unitType.counterAgainst(UnitClass.vehicle),
                    ),
                    Counter(
                      unitClass: UnitClass.aircraft,
                      value: unitType.counterAgainst(UnitClass.aircraft),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UnselectedCard extends StatelessWidget {
  final UnitType unitType;

  const UnselectedCard(this.unitType);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
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

  const SelectedCard(this.unitType);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 120,
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

  const Counter({
    required this.unitClass,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 33.33,
      height: 33.33,
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
