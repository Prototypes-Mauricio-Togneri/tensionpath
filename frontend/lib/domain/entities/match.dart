import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/entities/structures/structure_resources.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/entities/units/unit_fuel_truck.dart';
import 'package:tensionpath/domain/json/json_battlefield.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/json/json_player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/persistence/callables/json_utils.dart';
import 'package:tensionpath/persistence/callables/match/deploy_unit_callable.dart';
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

  void update(double dt) {
    _accumulatedResourcesInTurn += dt;
    _timeElapsed += dt;
  }

  void listen() =>
      MatchRepository.listen(matchId: id, onUpated: _onMatchUpated);

  void _onMatchUpated(JsonMatch json) {
    final Match newMatch = json.object(self.id);

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
    await DeployUnitCallable()(match: this, node: node, unit: unit);
  }

  Future onMoveUnit({
    required Unit unit,
    required Node nodeOrigin,
    required Node nodeTarget,
  }) async {
    await MoveUnitCallable()(
      match: this,
      unit: unit,
      nodeOrigin: nodeOrigin,
      nodeTarget: nodeTarget,
    );
  }

  int get _fuelCollected {
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

  Future onEndTurn() async {
    battlefield.nodes.forEach((node) => node.resetUnit());

    final JsonMatch json = JsonMatch(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: _turn + 1,
      activePlayer: opponent.id,
      players: [
        self.addResources(self.resourcesRate + _fuelCollected),
        opponent.addResources(accumulatedResourcesInTurn),
      ],
      battlefield: battlefield.toJson(),
    );
    await MatchRepository.update(json);
  }

  Future onOpponentEndTurn() async {
    battlefield.nodes.forEach((node) => node.resetUnit());
    final JsonMatch json = JsonMatch(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: _turn + 1,
      activePlayer: self.id,
      players: [JsonUtils.playerToJson(self), JsonUtils.playerToJson(opponent)],
      battlefield: battlefield.toJson(),
    );
    await MatchRepository.update(json);
  }

  JsonMatch toJson({
    List<JsonPlayer>? jsonPlayers,
    JsonBattlefield? jsonBattlefield,
  }) {
    return JsonMatch(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: _turn,
      activePlayer: _activePlayer,
      players:
          jsonPlayers ??
          [JsonUtils.playerToJson(self), JsonUtils.playerToJson(opponent)],
      battlefield: jsonBattlefield ?? battlefield.toJson(),
    );
  }
}
