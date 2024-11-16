import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/widgets/game_container.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance({
    required Battlefield battlefield,
  }) =>
      MatchScreen._(MatchState(battlefield));

  @override
  Widget build(BuildContext context) {
    return GameContainer(
      child: Content(state),
    );
  }
}

class Content extends StatelessWidget {
  final MatchState state;

  const Content(this.state);

  @override
  Widget build(BuildContext context) {
    if (state.gameState.hasGameComponent) {
      return GameWidget(
        game: state.gameState.gameComponent,
      );
    } else {
      return GameWidget(
        game: GameComponent(state.gameState),
      );
    }
  }
}
