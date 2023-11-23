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
          Lane(
            id: 'l1',
            area: const Rect.fromLTWH(100, 0, 200, 3000),
            waypoints: [
              Waypoint(
                id: 'w1a',
                position: Vector2(200, 2925),
                node: null,
              ),
              Waypoint(
                id: 'w1b',
                position: Vector2(200, 2500),
                node: null,
              ),
              Waypoint(
                id: 'w1c',
                position: Vector2(800, 2050),
                node: Node(
                  id: 'n1c',
                  position: Vector2(800, 2050),
                ),
              ),
              Waypoint(
                id: 'w1d',
                position: Vector2(800, 950),
                node: Node(
                  id: 'n1d',
                  position: Vector2(800, 950),
                ),
              ),
              Waypoint(
                id: 'w1e',
                position: Vector2(200, 500),
                node: null,
              ),
              Waypoint(
                id: 'w1f',
                position: Vector2(200, 75),
                node: null,
              ),
            ],
          ),
          Lane(
            id: 'l2',
            area: const Rect.fromLTWH(400, 0, 200, 3000),
            waypoints: [
              Waypoint(
                id: 'w2a',
                position: Vector2(500, 2925),
                node: null,
              ),
              Waypoint(
                id: 'w2b',
                position: Vector2(500, 1500),
                node: Node(
                  id: 'n2b',
                  position: Vector2(500, 1500),
                ),
              ),
              Waypoint(
                id: 'w2c',
                position: Vector2(500, 75),
                node: null,
              ),
            ],
          ),
          const Lane(
            id: 'l3',
            area: Rect.fromLTWH(700, 0, 200, 3000),
            waypoints: [],
          ),
        ],
      );
}
