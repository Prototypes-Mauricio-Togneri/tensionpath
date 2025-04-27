import 'dart:async';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/callables/match/attack_base_callable.dart';
import 'package:tensionpath/persistence/callables/match/attack_unit_callable.dart';
import 'package:tensionpath/persistence/callables/match/deploy_unit_callable.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_opponent_callable.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_self_callable.dart';
import 'package:tensionpath/persistence/callables/match/move_unit_callable.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';

class Match {
  final String id;
  final int version;
  final DateTime createdAt;
  final Player self;
  final Player opponent;
  final Battlefield battlefield;
  final Config config;
  late int _turn;
  late DateTime _lastTurnStartedAt;
  late String _activePlayer;

  Match({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.self,
    required this.opponent,
    required this.battlefield,
    required this.config,
    required int turn,
    required DateTime lastTurnStartedAt,
    required String activePlayer,
  }) {
    _turn = turn;
    _lastTurnStartedAt = lastTurnStartedAt;
    _activePlayer = activePlayer;
  }

  int get timeElapsed => DateTime.now().difference(createdAt).inSeconds;

  int get turn => _turn;

  bool get isSelfTurn => _activePlayer == self.id;

  String get activePlayer => _activePlayer;

  Player get player1 => self.isPlayer1 ? self : opponent;

  Player get player2 => self.isPlayer1 ? opponent : self;

  DateTime get lastTurnStartedAt => _lastTurnStartedAt;

  // TODO(momo): revert to calculated amount
  int get accumulatedResourcesInTurn => 5;
  //DateTime.now().difference(_lastTurnStartedAt).inSeconds;

  bool get selfWon => (self.baseHealth > 0) && (opponent.baseHealth <= 0);

  bool get opponentWon => (opponent.baseHealth > 0) && (self.baseHealth <= 0);

  int populationOf(Player player) {
    int result = 0;

    for (final Node node in battlefield.nodes) {
      if (node.hasUnit && node.unit!.belongsTo(player)) {
        result++;
      }
    }

    return result;
  }

  bool canDeployUnit(UnitType unitType) =>
      isSelfTurn &&
      (self.resources >= unitType.deploymentCost) &&
      (populationOf(self) < config.popcap);

  StreamSubscription listen() => MatchRepository.listen(
    matchId: id,
    selfId: self.id,
    onUpated: _onMatchUpated,
  );

  void _onMatchUpated(Match newMatch) {
    _turn = newMatch._turn;
    _lastTurnStartedAt = newMatch._lastTurnStartedAt;
    _activePlayer = newMatch._activePlayer;

    self.replaceWith(newMatch.self);
    opponent.replaceWith(newMatch.opponent);
    battlefield.replaceWith(self: self, newBattlefield: newMatch.battlefield);

    MatchComponentRef.instance.onMatchUpdated(this);
  }

  Future onDeployUnit({required Node node, required UnitType unitType}) async {
    final Unit unit = Unit.create(
      unitType: unitType,
      location: node.location,
      player: self,
      health: unitType.maxHealth,
      remainingMoves: 0,
      remainingAttacks: unitType.numberOfAttacks,
    );

    return DeployUnitCallable()(match: this, node: node, unit: unit);
  }

  Future onMoveUnit({
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) => MoveUnitCallable()(
    match: this,
    unit: unit,
    nodeOrigin: nodeOrigin,
    nodeTarget: nodeTarget,
  );

  Future onAttackUnit({
    required Unit unitAttacker,
    required Unit unitDefender,
  }) => AttackUnitCallable()(
    match: this,
    unitAttacker: unitAttacker,
    unitDefender: unitDefender,
  );

  Future onAttackBase({required Unit unit, required Node node}) =>
      AttackBaseCallable()(match: this, unit: unit, node: node);

  Future onEndTurn() {
    if (isSelfTurn) {
      return EndTurnSelfCallable()(this);
    } else {
      return Future.value();
    }
  }

  Future onOpponentEndTurn() => EndTurnOpponentCallable()(this);
}
