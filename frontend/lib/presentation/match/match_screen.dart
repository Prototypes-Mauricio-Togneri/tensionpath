import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/models/room.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/match/match_state.dart';
import 'package:tensionpath/widgets/base_screen.dart';

class MatchScreen extends StatelessWidget {
  final MatchState state;

  const MatchScreen._(this.state);

  factory MatchScreen.instance({
    required Room room,
    required Battlefield battlefield,
  }) =>
      MatchScreen._(MatchState(room, battlefield));

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: GameContent(state),
    );
  }
}

class GameContent extends StatelessWidget {
  final MatchState state;

  const GameContent(this.state);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: GameComponent(
        state: state.gameState,
        pixelRatio: MediaQuery.of(context).devicePixelRatio,
      ),
    );
  }
}
