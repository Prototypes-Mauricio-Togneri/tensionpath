import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionDeployUnit extends Action {
  final Location target;
  final int level;

  const ActionDeployUnit({
    required super.playerId,
    required this.target,
    required this.level,
  }) : super(type: ActionType.deploy);

  @override
  int get cost => level;
}
