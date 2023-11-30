import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/node.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/domain/types/node_type.dart';
import 'package:tensionpath/utils/sprites.dart';

class Battlefield {
  final String id;
  final Sprite sprite;
  final List<Lane> lanes;
  final List<Waypoint> waypoints = [];
  final List<Node> nodes = [];
  final Vector2 nodeSize;

  Battlefield({
    required this.id,
    required this.sprite,
    required this.lanes,
    required this.nodeSize,
  }) {
    for (final Lane lane in lanes) {
      waypoints.addAll(lane.waypoints);

      for (final Waypoint waypoint in lane.waypoints) {
        if (waypoint.hasNode) {
          nodes.add(waypoint.node!);
        }
      }
    }
  }

  Lane laneOf(Node node) {
    for (final Lane lane in lanes) {
      for (final Waypoint waypoint in lane.waypoints) {
        if (waypoint.node == node) {
          return lane;
        }
      }
    }

    throw Exception('Lane not found for node: ${node.id}');
  }

  factory Battlefield.lanes3() => Battlefield(
        id: 'lanes5',
        sprite: Sprites.BATTLEFIELD3,
        nodeSize: Vector2(200, 200),
        lanes: [
          Lane(
            id: 'l1',
            waypoints: [
              Waypoint(
                id: 'w1a',
                position: Vector2(200, 2900),
                node: Node(
                  id: 'n1a',
                  position: Vector2(200, 2900),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
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
                  type: NodeType.checkpoint,
                ),
              ),
              Waypoint(
                id: 'w1d',
                position: Vector2(800, 950),
                node: Node(
                  id: 'n1d',
                  position: Vector2(800, 950),
                  type: NodeType.chest,
                ),
              ),
              Waypoint(
                id: 'w1e',
                position: Vector2(200, 500),
                node: null,
              ),
              Waypoint(
                id: 'w1f',
                position: Vector2(200, 100),
                node: Node(
                  id: 'n1f',
                  position: Vector2(200, 100),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
          Lane(
            id: 'l2',
            waypoints: [
              Waypoint(
                id: 'w2a',
                position: Vector2(500, 2900),
                node: Node(
                  id: 'n2a',
                  position: Vector2(500, 2900),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w2b',
                position: Vector2(500, 1500),
                node: Node(
                  id: 'n2b',
                  position: Vector2(500, 1500),
                  type: NodeType.victory,
                ),
              ),
              Waypoint(
                id: 'w2c',
                position: Vector2(500, 100),
                node: Node(
                  id: 'n2c',
                  position: Vector2(500, 100),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
          Lane(
            id: 'l3',
            waypoints: [
              Waypoint(
                id: 'w3a',
                position: Vector2(800, 2900),
                node: Node(
                  id: 'n3a',
                  position: Vector2(800, 2900),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w3b',
                position: Vector2(800, 2500),
                node: null,
              ),
              Waypoint(
                id: 'w3c',
                position: Vector2(200, 2050),
                node: Node(
                  id: 'n3c',
                  position: Vector2(200, 2050),
                  type: NodeType.command_points_generator,
                ),
              ),
              Waypoint(
                id: 'w3d',
                position: Vector2(200, 950),
                node: Node(
                  id: 'n3d',
                  position: Vector2(200, 950),
                  type: NodeType.unit_generator,
                ),
              ),
              Waypoint(
                id: 'w3e',
                position: Vector2(800, 500),
                node: null,
              ),
              Waypoint(
                id: 'w3f',
                position: Vector2(800, 100),
                node: Node(
                  id: 'n3f',
                  position: Vector2(800, 100),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
        ],
      );

  factory Battlefield.lanes5() => Battlefield(
        id: 'lanes5',
        sprite: Sprites.BATTLEFIELD5,
        nodeSize: Vector2(150, 150),
        lanes: [
          Lane(
            id: 'l1',
            waypoints: [
              Waypoint(
                id: 'w1a',
                position: Vector2(133, 1625),
                node: Node(
                  id: 'n1a',
                  position: Vector2(133, 1625),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w1b',
                position: Vector2(133, 850),
                node: Node(
                  id: 'n1b',
                  position: Vector2(133, 850),
                  type: NodeType.chest,
                ),
              ),
              Waypoint(
                id: 'w1c',
                position: Vector2(133, 75),
                node: Node(
                  id: 'n1c',
                  position: Vector2(133, 75),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
          Lane(
            id: 'l2',
            waypoints: [
              Waypoint(
                id: 'w2a',
                position: Vector2(316, 1625),
                node: Node(
                  id: 'n2a',
                  position: Vector2(316, 1625),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w2b',
                position: Vector2(316, 1200),
                node: Node(
                  id: 'n2b',
                  position: Vector2(316, 1200),
                  type: NodeType.unit_generator,
                ),
              ),
              Waypoint(
                id: 'w2c',
                position: Vector2(316, 500),
                node: Node(
                  id: 'n2c',
                  position: Vector2(316, 500),
                  type: NodeType.command_points_generator,
                ),
              ),
              Waypoint(
                id: 'w2d',
                position: Vector2(316, 75),
                node: Node(
                  id: 'n2d',
                  position: Vector2(316, 75),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
          Lane(
            id: 'l3',
            waypoints: [
              Waypoint(
                id: 'w3a',
                position: Vector2(500, 1625),
                node: Node(
                  id: 'n3a',
                  position: Vector2(500, 1625),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w3b',
                position: Vector2(500, 850),
                node: Node(
                  id: 'n3b',
                  position: Vector2(500, 850),
                  type: NodeType.victory,
                ),
              ),
              Waypoint(
                id: 'w3c',
                position: Vector2(500, 75),
                node: Node(
                  id: 'n3c',
                  position: Vector2(500, 75),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
          Lane(
            id: 'l3',
            waypoints: [
              Waypoint(
                id: 'w3a',
                position: Vector2(684, 1625),
                node: Node(
                  id: 'n3a',
                  position: Vector2(684, 1625),
                  type: NodeType.launcher,
                  owner: Player.SELF,
                ),
              ),
              Waypoint(
                id: 'w3b',
                position: Vector2(684, 1200),
                node: Node(
                  id: 'n3b',
                  position: Vector2(684, 1200),
                  type: NodeType.command_points_generator,
                ),
              ),
              Waypoint(
                id: 'w3c',
                position: Vector2(684, 500),
                node: Node(
                  id: 'n3c',
                  position: Vector2(684, 500),
                  type: NodeType.unit_generator,
                ),
              ),
              Waypoint(
                id: 'w3d',
                position: Vector2(684, 75),
                node: Node(
                  id: 'n3d',
                  position: Vector2(684, 75),
                  type: NodeType.launcher,
                  owner: Player.ENEMY,
                ),
              ),
            ],
          ),
        ],
      );
}
