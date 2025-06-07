import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/location.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionDeployUnits extends Action {
  final Location target;
  final int amount;

  const ActionDeployUnits({
    required super.playerId,
    required this.target,
    required this.amount,
  }) : super(type: ActionType.deploy);

  @override
  int get cost => amount;
}
