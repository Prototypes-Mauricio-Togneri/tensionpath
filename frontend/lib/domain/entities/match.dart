import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/extensions/document_snapshot_extension.dart';
import 'package:tensionpath/utils/error_handler.dart';

class Match {
  final String id;
  Player self;
  Player opponent;
  Battlefield battlefield;

  Match({
    required this.id,
    required this.self,
    required this.opponent,
    required this.battlefield,
  });

  void listen() {
    FirebaseFirestore.instance.collection('matches').doc(id).snapshots().listen(
      (snapshot) async {
        if (snapshot.exists) {
          final JsonMatch json = JsonMatch.fromJson(snapshot.json);
          print('Match updated: $json');
        }
      },
      onError: ErrorHandler.process,
    );
  }

  static Future load({
    required String id,
    required Function(Match) onReady,
  }) async {
    final DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('matches').doc(id).get();

    if (snapshot.exists) {
      final JsonMatch json = JsonMatch.fromJson(snapshot.json);
      print('Match loaded: $json');

      final Player self = json.self;
      final Player opponent = json.opponent;
      final Battlefield battlefield = json.getBattlefield([self, opponent]);
      final Match match = Match(
        id: id,
        self: self,
        opponent: opponent,
        battlefield: battlefield,
      );
      onReady(match);
    }
  }
}
