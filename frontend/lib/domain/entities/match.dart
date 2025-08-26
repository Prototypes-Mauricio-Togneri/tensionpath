import 'dart:async';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class Match {
  final String id;
  final DateTime createdAt;
  final Player self;
  final Player opponent;
  final Battlefield battlefield;

  Match({
    required this.id,
    required this.createdAt,
    required this.self,
    required this.opponent,
    required this.battlefield,
  });

  int get timeElapsed => DateTime.now()
      .difference(DateTime.now().subtract(const Duration(seconds: 200)))
      .inSeconds;
  // DateTime.now().difference(createdAt).inSeconds;

  Player get player1 => self.isPlayer1 ? self : opponent;

  Player get player2 => self.isPlayer1 ? opponent : self;

  bool get selfWon => (self.baseHealth > 0) && (opponent.baseHealth <= 0);

  bool get opponentWon => (opponent.baseHealth > 0) && (self.baseHealth <= 0);

  int populationOf(Player player) {
    const int result = 0;

    /*for (final Node node in battlefield.nodes) {
      if (node.hasUnit && node.unit!.belongsTo(player)) {
        result++;
      }
    }*/

    return result;
  }

  bool canDeployUnit(UnitType unitType) =>
      self.resources >= unitType.deploymentCost;

  /*void _onMatchUpated(Match newMatch) {
    self.replaceWith(newMatch.self);
    opponent.replaceWith(newMatch.opponent);
    battlefield.replaceWith(self: self, newBattlefield: newMatch.battlefield);

    MatchComponentRef.instance.onMatchUpdated(this);
  }*/

  Future onDeployUnit({required Node node, required UnitType unitType}) async {
    /*final Unit unit = Unit.create(
      unitType: unitType,
      location: node.location,
      player: self,
      health: unitType.maxHealth,
      remainingMoves: 0,
      remainingAttacks: unitType.numberOfAttacks,
    );*/
  }
}
