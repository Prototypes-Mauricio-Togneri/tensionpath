import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';

class MatchState extends BaseState {
  GameComponent? gameComponent;

  MatchState() {
    restart();
  }

  bool get isInitialized => gameComponent != null;

  Future restart() =>
      Match.load(id: 'bkSVMdZ1UFZRfqCifqzq', onReady: onMatchReady);

  void onMatchReady(Match match) {
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
