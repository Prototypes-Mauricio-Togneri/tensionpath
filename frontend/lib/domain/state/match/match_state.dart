import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';

class MatchState extends BaseState {
  GameComponent? gameComponent;

  MatchState() {
    restart();
  }

  bool get isInitialized => gameComponent != null;

  Future restart() async {
    final Player self = Player.self();
    final Player enemy = Player.enemy();
    final Battlefield battlefield = await Battlefield.create(
      self: self,
      enemy: enemy,
    );

    gameComponent = GameComponent(
      state: this,
      self: self,
      enemy: enemy,
      battlefield: battlefield,
    );

    notify();
  }
}
