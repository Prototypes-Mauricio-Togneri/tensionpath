import 'package:tensionpath/domain/types/node_type.dart';

enum UnitClass {
  structure,
  harvester,
  infantry,
  vehicle,
  aircraft;

  static const num MOVEMENT_PENALTY = 1000;

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
        return MOVEMENT_PENALTY;
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
