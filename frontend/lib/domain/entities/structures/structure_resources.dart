import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_resources_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureResources extends Structure {
  const StructureResources()
    : super(type: StructureType.resources, player: null);

  @override
  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  }) => StructureResourcesComponent(
    structure: this,
    position: position,
    size: size,
  );
}
