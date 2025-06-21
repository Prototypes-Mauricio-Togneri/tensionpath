import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';
import 'package:tensionpath/domain/types/unit_type.dart';

class ActionDeployUnit extends Action {
  final Location target;
  final int level;
  final UnitType unitType;

  const ActionDeployUnit({
    required super.playerId,
    required this.target,
    required this.level,
    required this.unitType,
  }) : super(type: ActionType.deploy);

  @override
  int get cost => level;
}
