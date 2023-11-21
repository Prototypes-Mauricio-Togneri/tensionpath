import 'package:flame/components.dart';
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
          Lane(
            id: '1',
            position: Vector2(0, 0),
            size: Vector2(200, 3000),
            waypoints: [],
          ),
          Lane(
            id: '2',
            position: Vector2(200, 0),
            size: Vector2(200, 3000),
            waypoints: [],
          ),
          Lane(
            id: '3',
            position: Vector2(400, 0),
            size: Vector2(200, 3000),
            waypoints: [],
          ),
          Lane(
            id: '4',
            position: Vector2(600, 0),
            size: Vector2(200, 3000),
            waypoints: [],
          ),
          Lane(
            id: '5',
            position: Vector2(800, 0),
            size: Vector2(200, 3000),
            waypoints: [],
          ),
        ],
      );
}
