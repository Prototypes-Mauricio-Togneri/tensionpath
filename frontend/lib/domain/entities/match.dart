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
import 'package:tensionpath/utils/audio.dart';

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
    final bool isNewTurn = newMatch.turn.turn > turn.turn;

    if (isNewTurn) {
      Audio.get.playSound(Audio.NEW_TURN);
    }

    turn.replaceWith(newMatch.turn);
    self.replaceWith(newPlayer: newMatch.self, isNewTurn: isNewTurn);
    opponent.replaceWith(newPlayer: newMatch.opponent, isNewTurn: isNewTurn);
    battlefield.replaceWith(self: self, newBattlefield: newMatch.battlefield);

    MatchComponentRef.instance.onMatchUpdated(this);
  }

  bool _canDeployUnit({required Node node, required int amount}) =>
      (self.resources >= amount) &&
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

      for (int i = 0; i < locations.length; i++) {
        final Location location = locations[i];
        final Node node = battlefield.nodeById(location.id);

        if (_cannotPassThroughNode(
          node: node,
          lastNode: i == locations.length - 1,
        )) {
          return false;
        }
      }

      return true;
    } else {
      return false;
    }
  }

  bool _cannotPassThroughNode({required Node node, required bool lastNode}) {
    final bool invalidStructure =
        node.structure != null && !node.structure!.type.canMoveUnit;
    final bool nodeHasUnits = !lastNode && node.hasUnits;
    final bool isNotRevealed = !lastNode && !node.isRevealed;

    return invalidStructure || nodeHasUnits || isNotRevealed;
  }

  bool _canMoveUnit(Node node) =>
      isSelfPlaying && node.hasUnits && node.units!.belongsTo(self);

  void onDeployUnit({required Node nodeTarget, required int amount}) {
    if (_canDeployUnit(node: nodeTarget, amount: amount)) {
      final int cashBack = self.addAction(
        ActionDeployUnits(
          playerId: self.id,
          target: nodeTarget.location,
          amount: amount,
        ),
      );
      self.spendResources(amount - cashBack);
      MatchComponentRef.instance.reconfigure();
    }
  }

  void onDeployMaxUnits(Node nodeTarget) {
    if (self.resources > 0) {
      onDeployUnit(nodeTarget: nodeTarget, amount: self.resources);
    } else {
      self.removeDeploymentAction(nodeTarget.location);
    }
  }

  void onMoveUnit({required Node nodeOrigin, required Node nodeTarget}) {
    if (validTarget(nodeOrigin: nodeOrigin, nodeTarget: nodeTarget)) {
      final int distance = nodeTarget.distance(nodeOrigin);
      final int cost = distance * Constants.COST_MOVE_UNIT;

      if (self.resources >= cost) {
        if (_canMoveUnit(nodeOrigin)) {
          final int cashBack = self.addAction(
            ActionMoveUnits(
              playerId: self.id,
              origin: nodeOrigin.location,
              target: nodeTarget.location,
            ),
          );
          self.spendResources(cost - cashBack);
          MatchComponentRef.instance.reconfigure();
        }
      } else {
        CustomSnackbar.insufficientResources();
      }
    } else {
      CustomSnackbar.invalidTarget();
    }
  }

  void onCancelUnitMovement(Node nodeOrigin) {
    self.removeMovementAction(nodeOrigin.location);
    MatchComponentRef.instance.reconfigure();
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
