import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tensionpath/domain/entities/battlefield.dart';
import 'package:tensionpath/domain/entities/players/player.dart';
import 'package:tensionpath/domain/json/json_match.dart';
import 'package:tensionpath/utils/error_handler.dart';

class Match {
  final String id;
  Player self;
  Player enemy;
  Battlefield battlefield;

  Match({
    required this.id,
    required this.self,
    required this.enemy,
    required this.battlefield,
  });

  void listen() {
    FirebaseFirestore.instance.collection('matches').doc(id).snapshots().listen(
      (snapshot) async {
        if (snapshot.exists) {
          final Map<String, dynamic>? data = snapshot.data();

          if (data != null) {
            final JsonMatch json = JsonMatch.fromJson(data);
            print('Match updated: $json');
          }
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
      final Map<String, dynamic>? data =
          snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        final JsonMatch json = JsonMatch.fromJson(data);
        print('Match loaded: $json');

        final Player self = Player.self();
        final Player enemy = Player.enemy();
        final Battlefield battlefield = await Battlefield.create(
          self: self,
          enemy: enemy,
        );

        final Match match = Match(
          id: id,
          self: self,
          enemy: enemy,
          battlefield: battlefield,
        );
        onReady(match);
      }
    }
  }
}
