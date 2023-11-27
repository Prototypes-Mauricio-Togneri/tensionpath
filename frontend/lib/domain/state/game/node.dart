import 'package:flame/components.dart';
import 'package:tensionpath/domain/types/node_type.dart';

class Node {
  final String id;
  final Vector2 position;
  final NodeType type;

  Node({
    required this.id,
    required this.position,
    required this.type,
  });
}
