import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class MatchState extends BaseState {
  final String matchId;
  final String selfId;
  GameComponent? gameComponent;

  MatchState({required this.matchId, required this.selfId});

  bool get isInitialized => gameComponent != null;

  @override
  void onLoad() {
    // TODO(momo): load directly into variable without using callback
    MatchRepository.load(
      matchId: matchId,
      selfId: selfId,
      onLoaded: _onMatchLoaded,
    );
  }

  void _onMatchLoaded(Match match) {
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
