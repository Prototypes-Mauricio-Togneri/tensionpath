import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_pad_component.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructurePad extends Structure {
  final String platformId;

  StructurePad({required super.position, required this.platformId})
    : super(type: StructureType.pad);

  @override
  String? get getPlatformId => platformId;

  @override
  StructureComponent component({
    required Vector2 position,
    required Vector2 size,
  }) => StructurePadComponent(structure: this, position: position, size: size);
}
