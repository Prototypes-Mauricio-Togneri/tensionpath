import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_missile_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureMissile extends Structure {
  const StructureMissile({required super.location})
    : super(type: StructureType.missile, player: null);

  @override
  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  }) => StructureMissileComponent(
    structure: this,
    position: position,
    size: size,
  );
}
