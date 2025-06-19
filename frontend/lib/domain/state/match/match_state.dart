import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class MatchState extends BaseState {
  final String matchId;
  final String userId;
  GameComponent? gameComponent;

  MatchState({required this.matchId, required this.userId});

  bool get isInitialized => gameComponent != null;

  @override
  void onLoad() {
    MatchRepository.load(
      matchId: matchId,
      userId: userId,
      onLoaded: _onMatchLoaded,
    );
  }

  void onMenu() => gameComponent?.onMenu();

  void _onMatchLoaded(Match match) {
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
