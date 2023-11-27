import 'package:flame/components.dart';
import 'package:tensionpath/domain/state/game/player.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node {
  final String id;
  final Vector2 position;
  final NodeType type;
  Player? owner;

  Node({
    required this.id,
    required this.position,
    required this.type,
  });
}
