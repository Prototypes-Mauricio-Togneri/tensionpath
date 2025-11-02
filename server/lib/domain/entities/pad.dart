import 'package:tensionpath/domain/data/units.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/entities/unit.dart';
import 'package:tensionpath/domain/json/models/start/json_pad_start.dart';
import 'package:tensionpath/utils/constants.dart';

class Pad {
  final Location location;
  final Position position;
  final Node node;
  String? owner;

  Pad({
    required this.location,
    required this.position,
    required this.node,
  });

  /*
    null: none
    '1': player 1
    '2': player 2
  */
  void update(Units units) {
    if (node.isLocked) {
      owner = node.lockedUnit?.player.index;
    } else {
      int player1 = 0;
      int player2 = 0;

      for (final Unit unit in units.list) {
        if (unit.closestNode == node) {
          if (unit.player.index == Constants.PLAYER_1) {
            player1++;
          } else if (unit.player.index == Constants.PLAYER_2) {
            player2++;
          }
        }
      }

      if ((player1 > 0) && (player2 == 0)) {
        owner = Constants.PLAYER_1;
      } else if ((player2 > 0) && (player1 == 0)) {
        owner = Constants.PLAYER_2;
      } else {
        owner = null;
      }
    }
  }

  factory Pad.fromJson({
    required JsonPadStart json,
    required Node node,
  }) => Pad(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    node: node,
  );

  JsonPadStart toJson() => JsonPadStart(
    location: location.toJson(),
    position: position.toJson(),
  );
}
