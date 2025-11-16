import 'package:tensionpath/domain/types/node_type.dart';

enum UnitClass {
  structure,
  harvester,
  infantry,
  vehicle,
  aircraft
  ;

  bool get isLand =>
      (this == UnitClass.structure) ||
      (this == UnitClass.infantry) ||
      (this == UnitClass.harvester) ||
      (this == UnitClass.vehicle);

  bool get isAir => this == UnitClass.aircraft;

  bool canGoOver(UnitClass otherClazz) => otherClazz.isLand && isAir;

  num movingCost(NodeType nodeType) {
    switch (this) {
      case UnitClass.structure:
        return double.infinity;
      case UnitClass.infantry:
        return _movingCostInfantry(nodeType);
      case UnitClass.harvester:
      case UnitClass.vehicle:
        return _movingCostVehicle(nodeType);
      case UnitClass.aircraft:
        return _movingCostAircraft(nodeType);
    }
  }

  num _movingCostInfantry(NodeType nodeType) {
    switch (nodeType) {
      case NodeType.building:
      case NodeType.missile:
      case NodeType.rocks_low:
        return double.infinity;
      case NodeType.resources:
        return 1;
      case NodeType.pad:
      case NodeType.empty:
        return 0;
    }
  }

  num _movingCostVehicle(NodeType nodeType) {
    switch (nodeType) {
      case NodeType.building:
      case NodeType.missile:
      case NodeType.rocks_low:
        return double.infinity;
      case NodeType.resources:
      case NodeType.pad:
      case NodeType.empty:
        return 0;
    }
  }

  num _movingCostAircraft(NodeType nodeType) {
    switch (nodeType) {
      case NodeType.building:
        return double.infinity;
      case NodeType.missile:
      case NodeType.rocks_low:
      case NodeType.resources:
      case NodeType.pad:
      case NodeType.empty:
        return 0;
    }
  }
}
