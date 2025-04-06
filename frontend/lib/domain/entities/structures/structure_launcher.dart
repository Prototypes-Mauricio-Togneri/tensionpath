import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_launcher_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureLauncher extends Structure {
  StructureLauncher({required super.structurePlayer})
    : super(type: StructureType.launcher);

  @override
  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  }) => StructureLauncherComponent(
    structure: this,
    position: position,
    size: size,
  );
}
