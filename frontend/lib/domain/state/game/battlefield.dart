import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/nodes/node_checkpoint_component.dart';
import 'package:tensionpath/domain/components/nodes/node_chest_component.dart';
import 'package:tensionpath/domain/components/nodes/node_component.dart';
import 'package:tensionpath/domain/components/nodes/node_credit_generator.dart';
import 'package:tensionpath/domain/components/nodes/node_launcher_component.dart';
import 'package:tensionpath/domain/components/nodes/node_unit_generator.dart';
import 'package:tensionpath/domain/components/nodes/node_victory_component.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/state/game/waypoint.dart';
import 'package:tensionpath/utils/sprites.dart';

class Battlefield {
  final String id;
  final Sprite sprite;
  final Vector2 mapSize;
  final List<Lane> lanes;
  final List<Waypoint> waypoints = [];
  final List<NodeComponent> nodes = [];
  final Vector2 nodeSize;

  Battlefield({
    required this.id,
    required this.sprite,
    required this.mapSize,
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

  Lane laneOf(NodeComponent node) {
    for (final Lane lane in lanes) {
      for (final Waypoint waypoint in lane.waypoints) {
        if (waypoint.node == node) {
          return lane;
        }
      }
    }

    throw Exception('Lane not found for node: ${node.id}');
  }

  factory Battlefield.lanes3() {
    final Vector2 nodeSize = Vector2(200, 200);

    return Battlefield(
      id: 'lanes5',
      sprite: Sprites.BATTLEFIELD_LANES_3,
      mapSize: Vector2(1000, 3000),
      nodeSize: nodeSize,
      lanes: [
        Lane(
          id: 'l1',
          waypoints: [
            Waypoint(
              id: 'w1a',
              position: Vector2(200, 2900),
              node: NodeLauncherComponent(
                id: 'n1a',
                position: Vector2(200, 2900),
                owner: Player.SELF,
                size: nodeSize,
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
              node: NodeCheckpointComponent(
                id: 'n1c',
                position: Vector2(800, 2050),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w1d',
              position: Vector2(800, 950),
              node: NodeChestComponent(
                id: 'n1d',
                position: Vector2(800, 950),
                size: nodeSize,
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
              node: NodeLauncherComponent(
                id: 'n1f',
                position: Vector2(200, 100),
                owner: Player.ENEMY,
                size: nodeSize,
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
              node: NodeLauncherComponent(
                id: 'n2a',
                position: Vector2(500, 2900),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w2b',
              position: Vector2(500, 1500),
              node: NodeVictoryComponent(
                id: 'n2b',
                position: Vector2(500, 1500),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w2c',
              position: Vector2(500, 100),
              node: NodeLauncherComponent(
                id: 'n2c',
                position: Vector2(500, 100),
                owner: Player.ENEMY,
                size: nodeSize,
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
              node: NodeLauncherComponent(
                id: 'n3a',
                position: Vector2(800, 2900),
                owner: Player.SELF,
                size: nodeSize,
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
              node: NodeCreditGeneratorComponent(
                id: 'n3c',
                position: Vector2(200, 2050),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w3d',
              position: Vector2(200, 950),
              node: NodeUnitGeneratorComponent(
                id: 'n3d',
                position: Vector2(200, 950),
                size: nodeSize,
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
              node: NodeLauncherComponent(
                id: 'n3f',
                position: Vector2(800, 100),
                owner: Player.ENEMY,
                size: nodeSize,
              ),
            ),
          ],
        ),
      ],
    );
  }

  factory Battlefield.lanes5() {
    final Vector2 nodeSize = Vector2(150, 150);

    return Battlefield(
      id: 'lanes5',
      sprite: Sprites.BATTLEFIELD_LANES_5,
      mapSize: Vector2(1000, 1700),
      nodeSize: nodeSize,
      lanes: [
        Lane(
          id: 'l1',
          waypoints: [
            Waypoint(
              id: 'w1a',
              position: Vector2(113, 1625),
              node: NodeLauncherComponent(
                id: 'n1a',
                position: Vector2(113, 1625),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w1b',
              position: Vector2(113, 850),
              node: NodeChestComponent(
                id: 'n1b',
                position: Vector2(113, 850),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w1c',
              position: Vector2(113, 75),
              node: NodeLauncherComponent(
                id: 'n1c',
                position: Vector2(113, 75),
                owner: Player.ENEMY,
                size: nodeSize,
              ),
            ),
          ],
        ),
        Lane(
          id: 'l2',
          waypoints: [
            Waypoint(
              id: 'w2a',
              position: Vector2(306, 1625),
              node: NodeLauncherComponent(
                id: 'n2a',
                position: Vector2(306, 1625),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w2b',
              position: Vector2(306, 1200),
              node: NodeUnitGeneratorComponent(
                id: 'n2b',
                position: Vector2(306, 1200),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w2c',
              position: Vector2(306, 500),
              node: NodeCreditGeneratorComponent(
                id: 'n2c',
                position: Vector2(306, 500),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w2d',
              position: Vector2(306, 75),
              node: NodeLauncherComponent(
                id: 'n2d',
                position: Vector2(306, 75),
                owner: Player.ENEMY,
                size: nodeSize,
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
              node: NodeLauncherComponent(
                id: 'n3a',
                position: Vector2(500, 1625),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w3b',
              position: Vector2(500, 850),
              node: NodeVictoryComponent(
                id: 'n3b',
                position: Vector2(500, 850),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w3c',
              position: Vector2(500, 75),
              node: NodeLauncherComponent(
                id: 'n3c',
                position: Vector2(500, 75),
                owner: Player.ENEMY,
                size: nodeSize,
              ),
            ),
          ],
        ),
        Lane(
          id: 'l4',
          waypoints: [
            Waypoint(
              id: 'w4a',
              position: Vector2(694, 1625),
              node: NodeLauncherComponent(
                id: 'n4a',
                position: Vector2(694, 1625),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w4b',
              position: Vector2(694, 1200),
              node: NodeCreditGeneratorComponent(
                id: 'n4b',
                position: Vector2(694, 1200),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w4c',
              position: Vector2(694, 500),
              node: NodeUnitGeneratorComponent(
                id: 'n4c',
                position: Vector2(694, 500),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w4d',
              position: Vector2(694, 75),
              node: NodeLauncherComponent(
                id: 'n4d',
                position: Vector2(694, 75),
                owner: Player.ENEMY,
                size: nodeSize,
              ),
            ),
          ],
        ),
        Lane(
          id: 'l5',
          waypoints: [
            Waypoint(
              id: 'w5a',
              position: Vector2(887, 1625),
              node: NodeLauncherComponent(
                id: 'n5a',
                position: Vector2(887, 1625),
                owner: Player.SELF,
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w5b',
              position: Vector2(887, 850),
              node: NodeCheckpointComponent(
                id: 'n5b',
                position: Vector2(887, 850),
                size: nodeSize,
              ),
            ),
            Waypoint(
              id: 'w5c',
              position: Vector2(887, 75),
              node: NodeLauncherComponent(
                id: 'n5c',
                position: Vector2(887, 75),
                owner: Player.ENEMY,
                size: nodeSize,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
