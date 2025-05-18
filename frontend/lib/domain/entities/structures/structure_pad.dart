import 'package:flame/components.dart';
import 'package:tensionpath/domain/components/structures/structure_component.dart';
import 'package:tensionpath/domain/components/structures/structure_pad_component.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructurePad extends Structure {
  final String platformId;

  StructurePad({required super.location, required this.platformId})
    : super(type: StructureType.pad);

  @override
  String? get getPlatformId => platformId;

  @override
  StructureComponent component({
    required Node node,
    required Vector2 position,
    required Vector2 size,
  }) => StructurePadComponent(
    node: node,
    structure: this,
    position: position,
    size: size,
  );
}
