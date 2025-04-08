import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_platform_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructurePlatform extends Structure {
  StructurePlatform() : super(type: StructureType.platform, player: null);

  @override
  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  }) => StructurePlatformComponent(
    structure: this,
    position: position,
    size: size,
  );
}
