import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/priority.dart';

class StructureComponent<S extends Structure> extends SpriteComponent {
  final Node node;
  final S structure;

  StructureComponent({
    required this.node,
    required this.structure,
    required super.position,
    required Vector2 size,
  }) : super(
         anchor: Anchor.center,
         priority: Priority.structure.value,
         size: size * 0.97,
       );
}
