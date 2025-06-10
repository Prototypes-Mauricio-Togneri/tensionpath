import 'package:dafluta/dafluta.dart';
import 'package:tensionpath/domain/components/game_component.dart';
import 'package:tensionpath/domain/entities/match.dart';
import 'package:tensionpath/persistence/callables/match/surrender_callable.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/presentation/dialogs/confirmation_dialog.dart';
import 'package:tensionpath/utils/navigation.dart';

class MatchState extends BaseState {
  final String matchId;
  final String selfId;
  GameComponent? gameComponent;

  MatchState({required this.matchId, required this.selfId});

  bool get isInitialized => gameComponent != null;

  @override
  void onLoad() {
    MatchRepository.load(
      matchId: matchId,
      selfId: selfId,
      onLoaded: _onMatchLoaded,
    );
  }

  void onClose() => ConfirmationDialog.quitMatch(_onSurrender);

  void _onSurrender() {
    SurrenderCallable()(matchId: matchId, selfId: selfId);
    Navigation.pop();
  }

  void _onMatchLoaded(Match match) {
    gameComponent = GameComponent(state: this, match: match);
    notify();
  }
}
