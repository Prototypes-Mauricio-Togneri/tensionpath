import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/nodes/node.dart';
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
  final int turn;
  final String activePlayer;
  Player self;
  Player opponent;
  Battlefield battlefield;

  Match({
    required this.id,
    required this.version,
    required this.createdAt,
    required this.turn,
    required this.activePlayer,
    required this.self,
    required this.opponent,
    required this.battlefield,
  });

  static DocumentReference ref(String id) =>
      FirebaseFirestore.instance.collection('matches').doc(id);

  void listen() => ref(id).snapshots().listen((snapshot) {
    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      onMatchUpated(json);
    }
  }, onError: ErrorHandler.process);

  static Future load({
    required String id,
    required Function(Match) onReady,
  }) async {
    final DocumentSnapshot snapshot = await ref(id).get();

    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      final Player self = json.self;
      final Player opponent = json.opponent;
      final Battlefield battlefield = json.getBattlefield([self, opponent]);
      final Match match = Match(
        id: id,
        version: json.version,
        createdAt: json.createdAt,
        turn: json.turn,
        activePlayer: json.activePlayer,
        self: self,
        opponent: opponent,
        battlefield: battlefield,
      );
      onReady(match);
    }
  }

  Future updateMatch(JsonMatch json) async {
    await ref(id).update(json.toJson());
  }

  void onMatchUpated(JsonMatch json) {
    print(json);
  }

  Future onDeployUnit({required Node node, required UnitType unitType}) async {
    if (self.hasResources(unitType.cost) && !node.containsUnit) {
      self.spendResources(unitType.cost);
      final Unit unit = Unit.fromType(unitType: unitType, player: self);

      final JsonMatch json = JsonMatch(
        id: id,
        version: version,
        createdAt: createdAt,
        turn: turn,
        activePlayer: activePlayer,
        players: [self.toJson(), opponent.toJson()],
        battlefield: battlefield.deployUnit(node: node, unit: unit),
      );
      await updateMatch(json);
    }
  }
}
