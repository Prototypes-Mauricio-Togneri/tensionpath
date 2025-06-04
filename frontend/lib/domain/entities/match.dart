import 'dart:async';
import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/components/match_component.dart';
import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/entities/actions/actions.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/config.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure_launcher.dart';
import 'package:tensionpath/domain/entities/turn.dart';
import 'package:tensionpath/domain/json/json_action.dart';
import 'package:tensionpath/domain/types/player_status.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_opponent_callable.dart';
import 'package:tensionpath/persistence/callables/match/end_turn_self_callable.dart';
import 'package:tensionpath/persistence/repository/match_repository.dart';
import 'package:tensionpath/presentation/snackbar.dart/custom_snackbar.dart';

class Match {
  final String id;
  final int version;
  final DateTime createdAt;
  final Player self;
  final Player opponent;
  final Battlefield battlefield;
  final Config config;
  final Turn turn;

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

  bool get isSelfPlaying => self.status == PlayerStatus.playing;

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
      isSelfPlaying &&
      !node.hasUnits &&
      node.hasStructure &&
      (node.structure is StructureLauncher) &&
      node.belongsTo(self) &&
      (populationOf(self) < config.popcap);

  bool validTarget({required Node nodeOrigin, required Node nodeTarget}) {
    if (nodeOrigin.location.isValidTarget(player: self, target: nodeTarget)) {
      final List<Location> locations = nodeOrigin.location.pathNodes(
        player: self,
        target: nodeTarget,
      );

      for (final Location location in locations) {
        final Node node = battlefield.nodeById(location.id);

        if (node.structure != null && !node.structure!.type.canMoveUnit) {
          return false;
        }
      }

      return true;
    } else {
      return false;
    }
  }

  bool _canMoveUnit(Node node) =>
      isSelfPlaying && node.hasUnits && node.units!.belongsTo(self);

  void onDeployUnit(Node nodeTarget) {
    if (self.resources >= Constants.COST_DEPLOY_UNIT) {
      if (_canDeployUnit(nodeTarget)) {
        self.spendResources(Constants.COST_DEPLOY_UNIT);
        self.addAction(
          ActionDeployUnits(
            playerId: self.id,
            target: nodeTarget.location,
            amount: 1,
          ),
        );
        MatchComponentRef.instance.reconfigure();
      }
    }
  }

  void onMoveUnit({required Node nodeOrigin, required Node nodeTarget}) {
    if (validTarget(nodeOrigin: nodeOrigin, nodeTarget: nodeTarget)) {
      final int distance = nodeTarget.distance(nodeOrigin);

      if (distance <= Constants.UNITS_MAX_MOVEMENT) {
        final int cost = distance * Constants.COST_MOVE_UNIT;

        if (self.resources >= cost) {
          if (_canMoveUnit(nodeOrigin)) {
            self.spendResources(cost);
            self.addAction(
              ActionMoveUnits(
                playerId: self.id,
                origin: nodeOrigin.location,
                target: nodeTarget.location,
              ),
            );
            MatchComponentRef.instance.reconfigure();
          }
        } else {
          CustomSnackbar.insufficientResources();
        }
      } else {
        CustomSnackbar.movementDistanceTooBig();
      }
    } else {
      CustomSnackbar.invalidTarget();
    }
  }

  Future onEndTurn() async {
    if (isSelfPlaying) {
      self.setWaiting();
      return EndTurnSelfCallable()(
        matchId: id,
        selfId: self.id,
        actions: _actionsToJson(self.actions),
      );
    }
  }

  Future onOpponentEndTurn() =>
      EndTurnOpponentCallable()(matchId: id, selfId: self.id);

  List<JsonAction> _actionsToJson(Actions actions) {
    final List<JsonAction> result = [];

    for (final Action action in actions) {
      if (action is ActionDeployUnits) {
        result.add(
          JsonAction(
            type: action.type,
            playerId: action.playerId,
            originX: null,
            originY: null,
            targetX: action.target.x,
            targetY: action.target.y,
            amount: action.amount,
          ),
        );
      } else if (action is ActionMoveUnits) {
        result.add(
          JsonAction(
            type: action.type,
            playerId: action.playerId,
            originX: action.origin.x,
            originY: action.origin.y,
            targetX: action.target.x,
            targetY: action.target.y,
            amount: null,
          ),
        );
      } else {
        throw Exception('Unsupported action type: ${action.runtimeType}');
      }
    }

    return result;
  }
}
