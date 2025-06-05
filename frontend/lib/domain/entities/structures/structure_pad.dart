import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructurePad extends Structure {
  final String platformId;

  StructurePad({required super.location, required this.platformId})
    : super(type: StructureType.pad);
}
