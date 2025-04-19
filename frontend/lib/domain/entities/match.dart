import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
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
  late int _turn;
  late String _activePlayer;
  double _accumulatedResourcesInTurn = 0;
  double _timeElapsed = 0;

  Match({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.self,
    required this.opponent,
    required this.battlefield,
    required int turn,
    required String activePlayer,
  }) {
    _turn = turn;
    _activePlayer = activePlayer;
  }

  int get timeElapsed => _timeElapsed.floor();

  int get turn => _turn;

  bool get isSelfTurn => _activePlayer == self.id;

  String get activePlayer => _activePlayer;

  Player get player1 => self.isPlayer1 ? self : opponent;

  Player get player2 => self.isPlayer1 ? opponent : self;

  int get accumulatedResourcesInTurn => _accumulatedResourcesInTurn.floor();

  int get fuelCollected {
    int result = 0;

    for (final Node node in battlefield.nodes) {
      if (node.hasStructure && node.hasUnit) {
        final Structure structure = node.structure!;
        final Unit unit = node.unit!;

        if ((structure is StructureResources) &&
            unit.belongsTo(self) &&
            (unit is UnitFuelTruck)) {
          result += Constants.FUEL_TRUCK_COLLECTION;
        }
      }
    }

    return result;
  }

  void update(double dt) {
    _accumulatedResourcesInTurn += dt;
    _timeElapsed += dt;
  }

  void listen() => MatchRepository.listen(
    matchId: id,
    selfId: self.id,
    onUpated: _onMatchUpated,
  );

  void _onMatchUpated(Match newMatch) {
    if (newMatch._activePlayer != _activePlayer) {
      _accumulatedResourcesInTurn = 0;
    }

    _turn = newMatch._turn;
    _activePlayer = newMatch._activePlayer;

    self.replaceWith(newMatch.self);
    opponent.replaceWith(newMatch.opponent);

    final Set<String> visibleNodes = {};

    for (final Node newNode in newMatch.battlefield.nodes) {
      final Node oldNode = battlefield.nodeByPosition(newNode.location);
      oldNode.setUnit(newNode.unit);
      oldNode.setStructure(newNode.structure);

      if (newNode.hasUnit) {
        final Unit unit = newNode.unit!;

        if (unit.belongsTo(self)) {
          visibleNodes.addAll(
            oldNode.visibleNodes(
              visibilityRange: unit.visibilityRange,
              nodes: newMatch.battlefield.nodes,
            ),
          );
        }
      }

      if (newNode.hasStructure) {
        final Structure structure = newNode.structure!;

        if (structure.belongsTo(self)) {
          visibleNodes.addAll(
            oldNode.visibleNodes(
              visibilityRange: structure.visibilityRange,
              nodes: newMatch.battlefield.nodes,
            ),
          );
        }
      }
    }

    for (final Node node in battlefield.nodes) {
      node.setRevealed(visibleNodes.contains(node.id));
    }
  }

  Future onDeployUnit({required Node node, required UnitType unitType}) async {
    final Unit unit = Unit.create(
      unitType: unitType,
      node: node,
      player: self,
      health: unitType.maxHealth,
      moves: unitType.movementRange,
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

  Future onEndTurn() => EndTurnSelfCallable()(this);

  Future onOpponentEndTurn() => EndTurnOpponentCallable()(this);
}
