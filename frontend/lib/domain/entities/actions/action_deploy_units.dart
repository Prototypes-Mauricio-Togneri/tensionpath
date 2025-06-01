import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionDeployUnits extends Action {
  final Node node;

  const ActionDeployUnits({required this.node}) : super(ActionType.deploy);
}
