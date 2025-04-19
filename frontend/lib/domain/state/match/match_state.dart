import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/persistence/database/match_repository.dart';

class MatchState extends BaseState {
  final String matchId;
  final String selfId;
  GameComponent? gameComponent;

  MatchState({required this.matchId, required this.selfId}) {
    restart();
  }

  bool get isInitialized => gameComponent != null;

  Future restart() =>
      MatchRepository.load(id: matchId, onLoaded: _onMatchLoaded);

  void _onMatchLoaded(JsonMatch json) {
    final Match match = json.object(selfId);
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
