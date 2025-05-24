import 'dart:async';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_unit.dart';
import 'package:tensionpath/domain/entities/actions/action_move_unit.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_opponent_callable.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_self_callable.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class Match {
  final String id;
  final int version;
  final DateTime createdAt;
  final Player self;
  final Player opponent;
  final Battlefield battlefield;
  final Config config;
  final Turn turn;
  final List<Action> actions = [];

  Match({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.self,
    required this.opponent,
    required this.battlefield,
    required this.config,
    required this.turn,
  });

  int get timeElapsed => DateTime.now().difference(createdAt).inSeconds;

  bool get hasActiveTurn {
    if (self.isPlayer1) {
      return turn.player1EndedTurnAt == null;
    } else if (self.isPlayer2) {
      return turn.player2EndedTurnAt == null;
    } else {
      return false;
    }
  }

  Player get player1 => self.isPlayer1 ? self : opponent;

  Player get player2 => self.isPlayer1 ? opponent : self;

  int get accumulatedResourcesInTurn {
    final int elapsedSeconds = DateTime.now()
        .difference(turn.startedAt)
        .inSeconds;

    return (elapsedSeconds * config.resourcesPerSecond).floor();
  }

  bool get selfWon => (self.baseHealth > 0) && (opponent.baseHealth <= 0);

  bool get opponentWon => (opponent.baseHealth > 0) && (self.baseHealth <= 0);

  int populationOf(Player player) {
    int result = 0;

    for (final Node node in battlefield.nodes) {
      if (node.hasUnits && node.units!.belongsTo(player)) {
        result++;
      }
    }

    return result;
  }

  StreamSubscription listen() => MatchRepository.listen(
    matchId: id,
    selfId: self.id,
    onUpdated: _onMatchUpated,
  );

  void _onMatchUpated(Match newMatch) {
    turn.replaceWith(newMatch.turn);
    self.replaceWith(newMatch.self);
    opponent.replaceWith(newMatch.opponent);
    battlefield.replaceWith(self: self, newBattlefield: newMatch.battlefield);

    MatchComponentRef.instance.onMatchUpdated(this);
  }

  bool _canDeployUnit(Node node) =>
      hasActiveTurn &&
      node.belongsTo(self) &&
      (self.resources >= Constants.COST_DEPLOY_UNIT) &&
      (populationOf(self) < config.popcap);

  bool _canMoveUnit(Node node) =>
      hasActiveTurn &&
      node.hasUnits &&
      node.units!.belongsTo(self) &&
      (self.resources >= Constants.COST_MOVE_UNIT);

  void onDeployUnit(Node nodeTarget) {
    if (_canDeployUnit(nodeTarget)) {
      self.spendResources(Constants.COST_DEPLOY_UNIT);
      actions.add(ActionDeployUnit(node: nodeTarget));
      nodeTarget.addUnit(self);
      MatchComponentRef.instance.reconfigure();
    }
  }

  void onMoveUnit({required Node nodeOrigin, required Node nodeTarget}) {
    if (_canMoveUnit(nodeOrigin)) {
      self.spendResources(Constants.COST_MOVE_UNIT);
      actions.add(
        ActionMoveUnit(nodeOrigin: nodeOrigin, nodeTarget: nodeTarget),
      );
      nodeOrigin.moveUnit(nodeTarget);
      MatchComponentRef.instance.reconfigure();
    }
  }

  Future onEndTurn() {
    if (hasActiveTurn) {
      return EndTurnSelfCallable()(this);
    } else {
      return Future.value();
    }
  }

  Future onOpponentEndTurn() => EndTurnOpponentCallable()(this);
}
