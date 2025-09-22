import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/position.dart';
import 'package:tensionpath/domain/json/models/start/json_pad_start.dart';

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

  void update() {
    owner = _newOwner;
  }

  String? get _newOwner {
    // TODO(momo): check what units are in the platform
    /*for (final Node node in nodes) {
      if (node.hasUnit) {
        if (node.unit!.player.isPlayer1) {
          player1++;
        } else if (node.unit!.player.isPlayer2) {
          player2++;
        }
      }
    }*/

    return null;
  }

  factory Pad.fromJson({
    required JsonPadStart json,
    required Node node,
  }) => Pad(
    location: Location.fromJson(json.location),
    position: Position.fromJson(json.position),
    node: node,
  );

  JsonPadStart toJsonStart() => JsonPadStart(
    location: location.toJson(),
    position: position.toJson(),
  );
}
