import 'package:flame/components.dart';

class Lane {
  final String id;
  final Vector2 position;
  final Vector2 size;

  const Lane({
    required this.id,
    required this.position,
    required this.size,
  });
}
