import 'package:tensionpath/domain/entities/node.dart';

class Platform {
  final String platformId;
  final List<Node> nodes;

  const Platform({required this.platformId, required this.nodes});

  String? get owner {
    int player1 = 0;
    int player2 = 0;

    for (final Node node in nodes) {
      if (node.hasUnit) {
        if (node.unit!.player.isPlayer1) {
          player1++;
        } else if (node.unit!.player.isPlayer2) {
          player2++;
        }
      }
    }

    if ((player1 > 0) && (player2 == 0)) {
      return '1';
    } else if ((player2 > 0) && (player1 == 0)) {
      return '2';
    } else if ((player1 > 0) && (player2 > 0)) {
      return '';
    } else {
      return null;
    }
  }
}
