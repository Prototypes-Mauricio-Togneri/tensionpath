import 'package:tensionpath/domain/entities/structures/structure.dart';
import 'package:tensionpath/domain/types/structure_type.dart';

class StructureObstacle extends Structure {
  StructureObstacle({required super.location})
    : super(type: StructureType.obstacle);
}
