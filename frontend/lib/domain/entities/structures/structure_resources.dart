import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureResources extends Structure {
  StructureResources({required super.location})
    : super(type: StructureType.resources);
}
