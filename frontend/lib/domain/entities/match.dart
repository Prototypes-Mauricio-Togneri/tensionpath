import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/entities/units/unit.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/domain/types/unit_type.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

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

  static DocumentReference ref(String id) =>
      FirebaseFirestore.instance.collection('matches').doc(id);

  bool get isSelfTurn => _activePlayer == self.id;

  Player get player1 => self.isPlayer1 ? self : opponent;

  Player get player2 => self.isPlayer1 ? opponent : self;

  int get accumulatedResourcesInTurn => _accumulatedResourcesInTurn.floor();

  void update(double dt) {
    _accumulatedResourcesInTurn += dt;
  }

  void listen() => ref(id).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      onMatchUpated(json);
    }
  }, onError: ErrorHandler.process);

  static Future load({
    required String id,
    required String selfId,
    required Function(Match) onReady,
  }) async {
    final DocumentSnapshot snapshot = await ref(id).get();

    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      onReady(json.object(selfId));
    }
  }

  Future updateMatch(JsonMatch json) async {
    await ref(id).update(json.toJson());
  }

  void onMatchUpated(JsonMatch json) {
    final Match newMatch = json.object(self.id);

    if (newMatch._activePlayer != _activePlayer) {
      _accumulatedResourcesInTurn = 0;
    }

    _turn = newMatch._turn;
    _activePlayer = newMatch._activePlayer;

    self.replaceWith(newMatch.self);
    opponent.replaceWith(newMatch.opponent);

    for (final Node newNode in newMatch.battlefield.nodes) {
      final Node oldNode = battlefield.nodeByPosition(newNode.x, newNode.y);
      oldNode.replaceWith(newNode);
    }
  }

  Future onDeployUnit({required Node node, required UnitType unitType}) async {
    if (self.hasResources(unitType.cost) && !node.hasUnit) {
      self.spendResources(unitType.cost);
      final Unit unit = Unit.fromType(unitType: unitType, player: self);
      final JsonMatch json = JsonMatch(
        id: id,
        version: version,
        createdAt: createdAt,
        turn: _turn,
        activePlayer: _activePlayer,
        players: [self.toJson(), opponent.toJson()],
        battlefield: battlefield.deployUnit(nodeTarget: node, unit: unit),
      );
      await updateMatch(json);
    }
  }

  Future onMoveUnit({
    required Node nodeOrigin,
    required Node nodeTarget,
  }) async {
    if (self.hasResources(1) && !nodeTarget.hasUnit) {
      self.spendResources(1);
      final distance = nodeOrigin.distance(nodeTarget);
      nodeOrigin.unit.increaseMoves(distance);
      final JsonMatch json = JsonMatch(
        id: id,
        version: version,
        createdAt: createdAt,
        turn: _turn,
        activePlayer: _activePlayer,
        players: [self.toJson(), opponent.toJson()],
        battlefield: battlefield.moveUnit(
          nodeOrigin: nodeOrigin,
          nodeTarget: nodeTarget,
        ),
      );
      await updateMatch(json);
    }
  }

  Future onPassTurn() async {
    final JsonMatch json = JsonMatch(
      id: id,
      version: version,
      createdAt: createdAt,
      turn: _turn + 1,
      activePlayer: opponent.id,
      players: [
        self.toJson(),
        opponent.addResources(accumulatedResourcesInTurn),
      ],
      battlefield: battlefield.toJson(),
    );
    await updateMatch(json);
  }
}
