import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/utils/sprites.dart';

class Battlefield {
  final String id;
  final Sprite sprite;
  final List<Lane> lanes;
  final List<Waypoint> waypoints = [];
  final List<Node> nodes = [];

  Battlefield({
    required this.id,
    required this.sprite,
    required this.lanes,
  }) {
    for (final Lane lane in lanes) {
      waypoints.addAll(lane.waypoints);

      for (final Waypoint waypoint in waypoints) {
        if (waypoint.hasNode) {
          nodes.add(waypoint.node!);
        }
      }
    }
  }

  factory Battlefield.test() => Battlefield(
        id: 'test',
        sprite: Sprites.BATTLEFIELD,
        lanes: [
          const Lane(
            id: '1',
            area: Rect.fromLTWH(0, 0, 200, 3000),
            waypoints: [],
          ),
          /*const Lane(
            id: '2',
            area: Rect.fromLTWH(200, 0, 200, 3000),
            waypoints: [],
          ),
          const Lane(
            id: '3',
            area: Rect.fromLTWH(350, 0, 200, 3000),
            waypoints: [],
          ),*/
        ],
      );
}
