import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class MatchState extends BaseState {
  late GameComponent gameComponent;

  MatchState() {
    restart();
  }

  void restart() {
    final Player self = Player.self();
    final Player enemy = Player.enemy();
    final Battlefield battlefield = Battlefield.create(
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
