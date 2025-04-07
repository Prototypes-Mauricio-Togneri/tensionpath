import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';

class MatchState extends BaseState {
  final String matchId;
  final String selfId;
  GameComponent? gameComponent;

  MatchState({
    required this.matchId,
    required this.selfId,
  }) {
    restart();
  }

  bool get isInitialized => gameComponent != null;

  Future restart() => Match.load(
    id: matchId,
    selfId: selfId,
    onReady: onMatchReady,
  );

  void onMatchReady(Match match) {
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
