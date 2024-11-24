import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/state/game/battlefield.dart';
import 'package:tensionpath/domain/state/game/game_engine.dart';
import 'package:tensionpath/domain/state/game/players/player.dart';

class MatchState extends BaseState {
  late GameComponent gameComponent;
  late GameEngine engine;

  MatchState() {
    restart();
  }

  void restart() {
    gameComponent = GameComponent(this);

    final Player self = Player.self();
    final Player enemy = Player.enemy();

    engine = GameEngine(
      gameComponent: gameComponent,
      self: self,
      enemy: enemy,
      battlefield: Battlefield.create(
        self: self,
        enemy: enemy,
      ),
    );

    notify();
  }
}
