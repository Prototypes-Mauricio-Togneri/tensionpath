import 'package:tensionpath/domain/entities/actions/action.dart';
import 'package:tensionpath/domain/entities/actions/action_deploy_units.dart';
import 'package:tensionpath/domain/entities/actions/action_move_units.dart';
import 'package:tensionpath/domain/entities/node.dart';

class Actions {
  final List<Action> _pending = [];

  void add(Action action) {
    if (action is ActionMoveUnits) {
      _removeMoveActions(action.nodeOrigin);
      _pending.add(action);
    } else if (action is ActionDeployUnits) {
      final bool alreadyExists = _pending.any(
        (existingAction) =>
            existingAction is ActionDeployUnits &&
            existingAction.node == action.node,
      );

      if (!alreadyExists) {
        _pending.add(action);
      }
    } else {
      throw Exception('Unsupported action type: ${action.runtimeType}');
    }
  }

  void _removeMoveActions(Node nodeOrigin) => _pending.removeWhere(
    (action) =>
        (action is ActionMoveUnits) && (action.nodeOrigin == nodeOrigin),
  );
}
