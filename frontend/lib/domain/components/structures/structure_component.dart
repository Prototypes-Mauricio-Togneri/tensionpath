import 'package:flame/components.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/priority.dart';

class StructureComponent<S extends Structure> extends SpriteComponent {
  final S structure;

  StructureComponent({
    required this.structure,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, priority: Priority.structure.value);
}
