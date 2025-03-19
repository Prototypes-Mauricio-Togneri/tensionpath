import 'dart:ui';
import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class MatchState extends BaseState {
  final Size size;
  GameComponent? gameComponent;

  MatchState(this.size) {
    restart();
  }

  bool get isInitialized => gameComponent != null;

  Future restart() async {
    final Size resolution = Size(
      (size.height * Constants.SCREEN_WIDTH / size.width).round().toDouble(),
      Constants.SCREEN_WIDTH,
    );
    final Player self = Player.self();
    final Player enemy = Player.enemy();
    final Battlefield battlefield = await Battlefield.create(
      self: self,
      enemy: enemy,
    );

    gameComponent = GameComponent(
      state: this,
      resolution: resolution,
      self: self,
      enemy: enemy,
      battlefield: battlefield,
    );

    notify();
  }
}
