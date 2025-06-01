import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureMissile extends Structure {
  StructureMissile({required super.location})
    : super(type: StructureType.missile);
}
