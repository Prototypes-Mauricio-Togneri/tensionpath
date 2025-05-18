import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_resources_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureResources extends Structure {
  StructureResources({required super.location})
    : super(type: StructureType.resources);

  @override
  StructureComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => StructureResourcesComponent(
    node: node,
    structure: this,
    position: position,
    size: size,
  );
}
