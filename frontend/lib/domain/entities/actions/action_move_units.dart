import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/node.dart';
import 'package:tensionpath/domain/types/action_type.dart';

class ActionMoveUnits extends Action {
  final Node nodeOrigin;
  final Node nodeTarget;

  const ActionMoveUnits({required this.nodeOrigin, required this.nodeTarget})
    : super(ActionType.move);
}
