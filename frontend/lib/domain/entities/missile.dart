import 'package:tensionpath/app/constants.dart';
import 'package:tensionpath/domain/entities/platform.dart';

class Missile {
  int charge;
  final int maxCharge;
  late final int bufferCharge;
  final int numberOfPlatforms;
  final List<Platform> platforms = [];

  Missile({
    required this.charge,
    required this.maxCharge,
    required this.numberOfPlatforms,
  }) {
    bufferCharge = (maxCharge * 0.8).floor();
  }

  void replaceWith(Missile newMissile) {
    charge = newMissile.charge;
  }

  void setPlatforms(List<Platform> newPlatforms) {
    platforms.clear();
    platforms.addAll(newPlatforms);
  }

  String? get owner {
    int player1 = 0;
    int player2 = 0;
    int none = 0;

    for (final Platform platform in platforms) {
      if (platform.owner == Constants.PLAYER_1) {
        player1++;
      } else if (platform.owner == Constants.PLAYER_2) {
        player2++;
      } else if (platform.owner == null) {
        none++;
      }
    }

    if (none == platforms.length) {
      return null;
    } else if (player1 > player2) {
      return Constants.PLAYER_1;
    } else if (player2 > player1) {
      return Constants.PLAYER_2;
    } else {
      return '';
    }
  }
}
