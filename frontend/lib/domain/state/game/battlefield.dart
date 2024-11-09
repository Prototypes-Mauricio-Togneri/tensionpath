import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/base.dart';
import 'package:tensionpath/domain/state/game/lane.dart';
import 'package:tensionpath/domain/state/game/nodes/node_checkpoint.dart';
import 'package:tensionpath/domain/state/game/nodes/node_chest.dart';
import 'package:tensionpath/domain/state/game/nodes/node_credit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_invisible.dart';
import 'package:tensionpath/domain/state/game/nodes/node_unit_generator.dart';
import 'package:tensionpath/domain/state/game/nodes/node_victory.dart';
import 'package:tensionpath/domain/state/game/player.dart';

class Battlefield {
  final String id;
  final List<Base> bases;
  final List<Lane> lanes;
  final Vector2 mapSize;
  final Vector2 nodeSize;

  Battlefield({
    required this.id,
    required this.bases,
    required this.lanes,
    required this.mapSize,
    required this.nodeSize,
  });

  double get laneWidth => mapSize.x / lanes.length;

  Base get baseSelf => bases.where((b) => b.player.isSelf).first;

  Base get baseEnemy => bases.where((b) => b.player.isEnemy).first;

  factory Battlefield.vector() {
    final Vector2 nodeSize = Vector2(150, 150);

    // ignore: prefer_const_constructors
    final Lane lane1 = Lane(
      id: 'l1',
      nodes: [],
    );

    lane1.nodes.addAll([
      NodeInvisible(
        id: 'n1a',
        lane: lane1,
        position: Vector2(100, 2575),
        size: nodeSize,
      ),
      NodeChest(
        id: 'n1b',
        lane: lane1,
        position: Vector2(100, 1250),
        size: nodeSize,
      ),
      NodeInvisible(
        id: 'n1c',
        lane: lane1,
        position: Vector2(100, -75),
        size: nodeSize,
      ),
    ]);

    // ignore: prefer_const_constructors
    final Lane lane2 = Lane(
      id: 'l2',
      nodes: [],
    );

    lane2.nodes.addAll([
      NodeInvisible(
        id: 'n2a',
        lane: lane2,
        position: Vector2(300, 2575),
        size: nodeSize,
      ),
      NodeUnitGenerator(
        id: 'n2b',
        lane: lane2,
        position: Vector2(300, 1666),
        size: nodeSize,
      ),
      NodeCreditGenerator(
        id: 'n2c',
        lane: lane2,
        position: Vector2(300, 833),
        size: nodeSize,
      ),
      NodeInvisible(
        id: 'n2d',
        lane: lane2,
        position: Vector2(300, -75),
        size: nodeSize,
      ),
    ]);

    // ignore: prefer_const_constructors
    final Lane lane3 = Lane(
      id: 'l3',
      nodes: [],
    );

    lane3.nodes.addAll([
      NodeInvisible(
        id: 'n3a',
        lane: lane3,
        position: Vector2(500, 2575),
        size: nodeSize,
      ),
      NodeVictory(
        id: 'n3b',
        lane: lane3,
        position: Vector2(500, 1250),
        size: nodeSize,
      ),
      NodeInvisible(
        id: 'n3c',
        lane: lane3,
        position: Vector2(500, -75),
        size: nodeSize,
      ),
    ]);

    // ignore: prefer_const_constructors
    final Lane lane4 = Lane(
      id: 'l4',
      nodes: [],
    );

    lane4.nodes.addAll([
      NodeInvisible(
        id: 'n4a',
        lane: lane4,
        position: Vector2(700, 2575),
        size: nodeSize,
      ),
      NodeCreditGenerator(
        id: 'n4b',
        lane: lane4,
        position: Vector2(700, 1666),
        size: nodeSize,
      ),
      NodeUnitGenerator(
        id: 'n4c',
        lane: lane4,
        position: Vector2(700, 833),
        size: nodeSize,
      ),
      NodeInvisible(
        id: 'n4d',
        lane: lane4,
        position: Vector2(700, -75),
        size: nodeSize,
      ),
    ]);

    // ignore: prefer_const_constructors
    final Lane lane5 = Lane(
      id: 'l5',
      nodes: [],
    );

    lane5.nodes.addAll([
      NodeInvisible(
        id: 'n5a',
        lane: lane5,
        position: Vector2(900, 2575),
        size: nodeSize,
      ),
      NodeCheckpoint(
        id: 'n5b',
        lane: lane5,
        position: Vector2(900, 1250),
        size: nodeSize,
      ),
      NodeInvisible(
        id: 'n5c',
        lane: lane5,
        position: Vector2(900, -75),
        size: nodeSize,
      ),
    ]);

    return Battlefield(
      id: 'vector',
      mapSize: Vector2(1000, 2500),
      nodeSize: nodeSize,
      bases: [
        Base(
          player: Player.SELF,
          hp: 100,
        ),
        Base(
          player: Player.ENEMY,
          hp: 100,
        ),
      ],
      lanes: [
        lane1,
        lane2,
        lane3,
        lane4,
        lane5,
      ],
    );
  }
}
